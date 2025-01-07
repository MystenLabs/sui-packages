module 0xc87453ed98366ad5ac663df89410ddd1596b2b6d8153da942eb2a61c8080755a::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>,
        init_reward: u64,
        operator_pk: vector<u8>,
        boat_level: 0x2::table_vec::TableVec<BoatLevel>,
        mesh_level: 0x2::table_vec::TableVec<MeshLevel>,
        seafood_level: 0x2::table_vec::TableVec<SeafoodLevel>,
        special_boost: 0x2::table_vec::TableVec<SpecialBoost>,
        gas_fee: u16,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
    }

    struct BoatLevel has store {
        fishing_time: u32,
        price_upgrade: u64,
    }

    struct MeshLevel has store {
        speed: u32,
        price_upgrade: u64,
    }

    struct SeafoodLevel has store {
        rate: u32,
    }

    struct SpecialBoost has store {
        type: u8,
        rate: u32,
        start_time: u64,
        duration: u64,
    }

    struct User has store, key {
        id: 0x2::object::UID,
        boat: u8,
        mesh: u8,
        seafood: u8,
        special_boost: 0x1::option::Option<u16>,
        special_boost_start_time: u64,
        village: 0x1::option::Option<u64>,
        referral: address,
        last_claim: u64,
    }

    struct ClaimToken has copy, drop, store {
        receiver: address,
        amount: u64,
    }

    struct UpgradeLevel has copy, drop, store {
        type: u8,
        user_address: address,
        level: u16,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    entry fun admin_claim(arg0: &mut GameInfo, arg1: address, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x1::string::utf8(b"AD_CLAIM:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 3);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 9);
        inner_claim(arg0, arg1, arg2, arg5, arg6);
    }

    entry fun claim(arg0: &mut GameInfo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        inner_claim(arg0, v0, false, arg1, arg2);
    }

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v1) == true, 3);
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        let v2 = User{
            id                       : 0x2::object::new(arg5),
            boat                     : 0,
            mesh                     : 0,
            seafood                  : 0,
            special_boost            : 0x1::option::none<u16>(),
            special_boost_start_time : 0,
            village                  : 0x1::option::none<u64>(),
            referral                 : arg2,
            last_claim               : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::dynamic_object_field::add<address, User>(&mut arg0.id, arg1, v2);
        let v3 = arg0.init_reward;
        if (v3 > 0) {
            send_token(arg0, arg1, v3, arg5);
            if (arg2 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2)) {
                let v4 = v3 * (arg0.ref1 as u64) / 10000;
                send_token(arg0, arg2, v4, arg5);
                let v5 = 0x2::dynamic_object_field::borrow<address, User>(&arg0.id, arg2).referral;
                if (v5 != arg2 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v5)) {
                    let v6 = v3 * (arg0.ref2 as u64) / 10000;
                    send_token(arg0, v5, v6, arg5);
                };
            };
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table_vec::empty<BoatLevel>(arg0);
        let v1 = BoatLevel{
            fishing_time  : 20000,
            price_upgrade : 20000000000,
        };
        0x2::table_vec::push_back<BoatLevel>(&mut v0, v1);
        let v2 = BoatLevel{
            fishing_time  : 30000,
            price_upgrade : 40000000000,
        };
        0x2::table_vec::push_back<BoatLevel>(&mut v0, v2);
        let v3 = BoatLevel{
            fishing_time  : 40000,
            price_upgrade : 60000000000,
        };
        0x2::table_vec::push_back<BoatLevel>(&mut v0, v3);
        let v4 = BoatLevel{
            fishing_time  : 60000,
            price_upgrade : 100000000000,
        };
        0x2::table_vec::push_back<BoatLevel>(&mut v0, v4);
        let v5 = BoatLevel{
            fishing_time  : 120000,
            price_upgrade : 160000000000,
        };
        0x2::table_vec::push_back<BoatLevel>(&mut v0, v5);
        let v6 = BoatLevel{
            fishing_time  : 240000,
            price_upgrade : 320000000000,
        };
        0x2::table_vec::push_back<BoatLevel>(&mut v0, v6);
        let v7 = 0x2::table_vec::empty<MeshLevel>(arg0);
        let v8 = MeshLevel{
            speed         : 10000,
            price_upgrade : 20000000000,
        };
        0x2::table_vec::push_back<MeshLevel>(&mut v7, v8);
        let v9 = MeshLevel{
            speed         : 15000,
            price_upgrade : 100000000000,
        };
        0x2::table_vec::push_back<MeshLevel>(&mut v7, v9);
        let v10 = MeshLevel{
            speed         : 20000,
            price_upgrade : 200000000000,
        };
        0x2::table_vec::push_back<MeshLevel>(&mut v7, v10);
        let v11 = MeshLevel{
            speed         : 25000,
            price_upgrade : 400000000000,
        };
        0x2::table_vec::push_back<MeshLevel>(&mut v7, v11);
        let v12 = MeshLevel{
            speed         : 30000,
            price_upgrade : 2000000000000,
        };
        0x2::table_vec::push_back<MeshLevel>(&mut v7, v12);
        let v13 = MeshLevel{
            speed         : 50000,
            price_upgrade : 4000000000000,
        };
        0x2::table_vec::push_back<MeshLevel>(&mut v7, v13);
        let v14 = 0x2::table_vec::empty<SeafoodLevel>(arg0);
        let v15 = SeafoodLevel{rate: 10000};
        0x2::table_vec::push_back<SeafoodLevel>(&mut v14, v15);
        let v16 = SeafoodLevel{rate: 12500};
        0x2::table_vec::push_back<SeafoodLevel>(&mut v14, v16);
        let v17 = SeafoodLevel{rate: 15000};
        0x2::table_vec::push_back<SeafoodLevel>(&mut v14, v17);
        let v18 = SeafoodLevel{rate: 17500};
        0x2::table_vec::push_back<SeafoodLevel>(&mut v14, v18);
        let v19 = SeafoodLevel{rate: 20000};
        0x2::table_vec::push_back<SeafoodLevel>(&mut v14, v19);
        let v20 = SeafoodLevel{rate: 25000};
        0x2::table_vec::push_back<SeafoodLevel>(&mut v14, v20);
        let v21 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v21, 0x2::tx_context::sender(arg0));
        let v22 = @0xa53aa06e26253b5fac6a3558203366c50c93cdb0a6df0e3c2d8c26386a2535a1;
        let v23 = GameInfo{
            id            : 0x2::object::new(arg0),
            version       : 1,
            balance       : 0x2::balance::zero<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(),
            init_reward   : 1000000000,
            operator_pk   : 0x2::bcs::to_bytes<address>(&v22),
            boat_level    : v0,
            mesh_level    : v7,
            seafood_level : v14,
            special_boost : 0x2::table_vec::empty<SpecialBoost>(arg0),
            gas_fee       : 3000,
            ref1          : 2000,
            ref2          : 500,
            v_ref         : 500,
        };
        0x2::transfer::share_object<GameInfo>(v23);
    }

    fun inner_claim(arg0: &mut GameInfo, arg1: address, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, arg1);
        let v1 = 0x2::table_vec::borrow<BoatLevel>(&arg0.boat_level, (v0.boat as u64));
        let v2 = 0x2::table_vec::borrow<MeshLevel>(&arg0.mesh_level, (v0.mesh as u64));
        let v3 = 0x2::table_vec::borrow<SeafoodLevel>(&arg0.seafood_level, (v0.seafood as u64));
        let v4 = 0x2::clock::timestamp_ms(arg3);
        assert!(v4 - v0.last_claim >= (v1.fishing_time as u64) * 60 * 60 * 1000 / 10000, 6);
        v0.last_claim = v4;
        let v5 = 1000000000 * (v1.fishing_time as u64) / 10000 * (v2.speed as u64) / 10000 * (v3.rate as u64) / 10000;
        let v6 = v5;
        if (0x1::option::is_some<u16>(&v0.special_boost)) {
            let v7 = 0x2::table_vec::borrow<SpecialBoost>(&arg0.special_boost, (0x1::option::extract<u16>(&mut v0.special_boost) as u64));
            if (v7.type == 0 && v4 >= v7.start_time && v4 <= v7.start_time + v7.duration) {
                v6 = v5 * (v7.rate as u64) / 10000;
            };
            if (v7.type == 1 && v4 >= v0.special_boost_start_time && v4 <= v0.special_boost_start_time + v7.duration) {
                let v8 = v6 * (v7.rate as u64);
                v6 = v8 / 10000;
            };
        };
        let v9 = v6;
        if (arg2) {
            v9 = v6 * (10000 - (arg0.gas_fee as u64)) / 10000;
        };
        let v10 = v0.referral;
        send_token(arg0, arg1, v9, arg4);
        if (v10 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v10)) {
            let v11 = v6 * (arg0.ref1 as u64) / 10000;
            send_token(arg0, v10, v11, arg4);
            let v12 = 0x2::dynamic_object_field::borrow<address, User>(&arg0.id, v10).referral;
            if (v12 != v10 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v12)) {
                let v13 = v6 * (arg0.ref2 as u64) / 10000;
                send_token(arg0, v12, v13, arg4);
            };
        };
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut GameInfo) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    entry fun remove_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(&mut arg1.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg2));
    }

    fun send_token(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(0x2::coin::from_balance<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(0x2::balance::split<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&mut arg0.balance, arg2), arg3), arg1);
        } else if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(0x2::coin::from_balance<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(0x2::balance::withdraw_all<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&mut arg0.balance), arg3), arg1);
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(0x2::coin::mint<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3), arg1);
        };
        let v2 = ClaimToken{
            receiver : arg1,
            amount   : arg2,
        };
        0x2::event::emit<ClaimToken>(v2);
    }

    entry fun set_init_reward(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: u64) {
        arg1.init_reward = arg2;
    }

    entry fun set_ref1(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: u16) {
        arg1.ref1 = arg2;
    }

    entry fun set_ref2(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: u16) {
        arg1.ref2 = arg2;
    }

    entry fun update_boat_levels(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: vector<u64>, arg3: vector<u32>, arg4: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u32>(&arg3) && v0 == 0x1::vector::length<u64>(&arg4), 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<SeafoodLevel>(&arg1.seafood_level)) {
                let v3 = 0x2::table_vec::borrow_mut<BoatLevel>(&mut arg1.boat_level, v2);
                v3.fishing_time = *0x1::vector::borrow<u32>(&arg3, v1);
                v3.price_upgrade = *0x1::vector::borrow<u64>(&arg4, v1);
            } else {
                let v4 = BoatLevel{
                    fishing_time  : *0x1::vector::borrow<u32>(&arg3, v1),
                    price_upgrade : *0x1::vector::borrow<u64>(&arg4, v1),
                };
                0x2::table_vec::push_back<BoatLevel>(&mut arg1.boat_level, v4);
            };
            v1 = v1 + 1;
        };
    }

    entry fun update_gas_fee(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: u16) {
        assert!(arg2 <= 10000, 10);
        arg1.gas_fee = arg2;
    }

    entry fun update_mesh_levels(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: vector<u64>, arg3: vector<u32>, arg4: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u32>(&arg3) && v0 == 0x1::vector::length<u64>(&arg4), 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<MeshLevel>(&arg1.mesh_level)) {
                let v3 = 0x2::table_vec::borrow_mut<MeshLevel>(&mut arg1.mesh_level, v2);
                v3.speed = *0x1::vector::borrow<u32>(&arg3, v1);
                v3.price_upgrade = *0x1::vector::borrow<u64>(&arg4, v1);
            } else {
                let v4 = MeshLevel{
                    speed         : *0x1::vector::borrow<u32>(&arg3, v1),
                    price_upgrade : *0x1::vector::borrow<u64>(&arg4, v1),
                };
                0x2::table_vec::push_back<MeshLevel>(&mut arg1.mesh_level, v4);
            };
            v1 = v1 + 1;
        };
    }

    entry fun update_operator(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: vector<u8>) {
        arg1.operator_pk = arg2;
    }

    entry fun update_ref(arg0: &mut GameInfo, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 11);
        0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0).referral = arg1;
    }

    entry fun update_seafood_levels(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: vector<u64>, arg3: vector<u32>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u32>(&arg3), 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<SeafoodLevel>(&arg1.seafood_level)) {
                0x2::table_vec::borrow_mut<SeafoodLevel>(&mut arg1.seafood_level, v2).rate = *0x1::vector::borrow<u32>(&arg3, v1);
            } else {
                let v3 = SeafoodLevel{rate: *0x1::vector::borrow<u32>(&arg3, v1)};
                0x2::table_vec::push_back<SeafoodLevel>(&mut arg1.seafood_level, v3);
            };
            v1 = v1 + 1;
        };
    }

    entry fun update_special_boosts(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: vector<u64>, arg3: vector<u8>, arg4: vector<u32>, arg5: vector<u64>, arg6: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 == 0x1::vector::length<u32>(&arg4) && v0 == 0x1::vector::length<u64>(&arg5) && v0 == 0x1::vector::length<u64>(&arg6), 10);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u64>(&arg2, v1);
            if (v2 < 0x2::table_vec::length<SpecialBoost>(&arg1.special_boost)) {
                let v3 = 0x2::table_vec::borrow_mut<SpecialBoost>(&mut arg1.special_boost, v2);
                v3.type = *0x1::vector::borrow<u8>(&arg3, v1);
                v3.rate = *0x1::vector::borrow<u32>(&arg4, v1);
                v3.start_time = *0x1::vector::borrow<u64>(&arg5, v1);
                v3.duration = *0x1::vector::borrow<u64>(&arg6, v1);
            } else {
                let v4 = SpecialBoost{
                    type       : *0x1::vector::borrow<u8>(&arg3, v1),
                    rate       : *0x1::vector::borrow<u32>(&arg4, v1),
                    start_time : *0x1::vector::borrow<u64>(&arg5, v1),
                    duration   : *0x1::vector::borrow<u64>(&arg6, v1),
                };
                0x2::table_vec::push_back<SpecialBoost>(&mut arg1.special_boost, v4);
            };
            v1 = v1 + 1;
        };
    }

    entry fun upgrade_boat(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0);
        let v2 = v1.boat + 1;
        assert!((v2 as u64) <= 0x2::table_vec::length<BoatLevel>(&arg0.boat_level) - 1, 7);
        let v3 = 0x2::table_vec::borrow<BoatLevel>(&arg0.boat_level, (v1.boat as u64));
        let v4 = 0x2::coin::value<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&arg1);
        assert!(v4 >= v3.price_upgrade, 8);
        let v5 = if (v4 > v3.price_upgrade) {
            0x2::pay::keep<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(arg1, arg2);
            0x2::coin::split<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&mut arg1, v3.price_upgrade, arg2)
        } else {
            arg1
        };
        0x2::balance::join<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&mut arg0.balance, 0x2::coin::into_balance<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(v5));
        v1.boat = v2;
        let v6 = UpgradeLevel{
            type         : 0,
            user_address : v0,
            level        : (v2 as u16),
        };
        0x2::event::emit<UpgradeLevel>(v6);
    }

    entry fun upgrade_mesh(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0);
        let v2 = v1.mesh + 1;
        assert!((v2 as u64) <= 0x2::table_vec::length<MeshLevel>(&arg0.mesh_level) - 1, 7);
        let v3 = 0x2::table_vec::borrow<MeshLevel>(&arg0.mesh_level, (v1.mesh as u64));
        let v4 = 0x2::coin::value<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&arg1);
        assert!(v4 >= v3.price_upgrade, 8);
        let v5 = if (v4 > v3.price_upgrade) {
            0x2::pay::keep<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(arg1, arg2);
            0x2::coin::split<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&mut arg1, v3.price_upgrade, arg2)
        } else {
            arg1
        };
        0x2::balance::join<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(&mut arg0.balance, 0x2::coin::into_balance<0x6fbdfbdaff0cf3b15ba5678733b463370108a9d2fc09c9eaf1e36b33744c9aef::wave::WAVE>(v5));
        v1.mesh = v2;
        let v6 = UpgradeLevel{
            type         : 1,
            user_address : v0,
            level        : (v2 as u16),
        };
        0x2::event::emit<UpgradeLevel>(v6);
    }

    entry fun upgrade_seafood(arg0: &mut GameInfo, arg1: u8, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x1::string::utf8(b"UP_SEAFOOD:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u8>(&arg1));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 3);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 9);
        assert!((arg1 as u64) <= 0x2::table_vec::length<SeafoodLevel>(&arg0.seafood_level) - 1, 7);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2), 5);
        0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, arg2).seafood = arg1;
        let v4 = UpgradeLevel{
            type         : 2,
            user_address : arg2,
            level        : (arg1 as u16),
        };
        0x2::event::emit<UpgradeLevel>(v4);
    }

    entry fun upgrade_special_boost(arg0: &mut GameInfo, arg1: u16, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg0.version == 1, 2);
        let v0 = 0x1::string::utf8(b"UP_BOOST:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u16>(&arg1));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 3);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        assert!(v4 < arg3, 9);
        assert!((arg1 as u64) <= 0x2::table_vec::length<SpecialBoost>(&arg0.special_boost) - 1, 7);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2), 5);
        let v5 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, arg2);
        v5.special_boost = 0x1::option::some<u16>(arg1);
        v5.special_boost_start_time = v4;
        let v6 = UpgradeLevel{
            type         : 3,
            user_address : arg2,
            level        : arg1,
        };
        0x2::event::emit<UpgradeLevel>(v6);
    }

    // decompiled from Move bytecode v6
}

