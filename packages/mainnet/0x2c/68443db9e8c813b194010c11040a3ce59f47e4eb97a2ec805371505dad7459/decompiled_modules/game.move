module 0x1efaf509c9b7e986ee724596f526a22b474b15c376136772c00b8452f204d2d1::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>,
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
        v_join_fee: u64,
        v_leave_fee: u64,
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
        village: 0x1::string::String,
        referral: address,
        last_claim: u64,
    }

    struct Village has store, key {
        id: 0x2::object::UID,
        village_id: 0x1::string::String,
        balance: 0x2::balance::Balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>,
        owner: address,
        num_of_members: u64,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
        init_reward: u64,
        village_id: 0x1::string::String,
    }

    struct ClaimToken has copy, drop, store {
        user_address: address,
        amount_user_received: u64,
        ref1_address: address,
        amount_ref1_received: u64,
        ref2_address: address,
        amount_ref2_received: u64,
        village_id: 0x1::string::String,
        amount_village_received: u64,
    }

    struct CreateVillage has copy, drop, store {
        village_id: 0x1::string::String,
        owner: address,
    }

    struct JoinVillage has copy, drop, store {
        village_id: 0x1::string::String,
        user_address: address,
        ref_address: address,
    }

    struct LeaveVillage has copy, drop, store {
        village_id: 0x1::string::String,
        user_address: address,
    }

    struct UpdateRef has copy, drop, store {
        user_address: address,
        new_ref: address,
    }

    struct UpgradeLevel has copy, drop, store {
        type: u8,
        user_address: address,
        level: u16,
        amount_upgrade: u64,
    }

    struct AppKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AppAuthInfo has drop, store {
        auth_type: u16,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    fun allocate_tokens(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow<address, User>(&arg0.id, arg1);
        let v1 = arg2;
        if (arg3) {
            v1 = arg2 * (10000 - (arg0.gas_fee as u64)) / 10000;
        };
        let v2 = v0.referral;
        let v3 = @0x0;
        let v4 = v0.village;
        let v5 = 0;
        let v6 = 0;
        send_tokens(arg0, arg1, v1, arg4);
        if (v2 != @0x0 && v2 != arg1 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v2)) {
            let v7 = arg2 * (arg0.ref1 as u64) / 10000;
            v5 = v7;
            send_tokens(arg0, v2, v7, arg4);
            let v8 = 0x2::dynamic_object_field::borrow<address, User>(&arg0.id, v2).referral;
            v3 = v8;
            if (v8 != @0x0 && v8 != v2 && 0x2::dynamic_object_field::exists_<address>(&arg0.id, v8)) {
                let v9 = arg2 * (arg0.ref2 as u64) / 10000;
                v6 = v9;
                send_tokens(arg0, v8, v9, arg4);
            };
        };
        let v10 = 0;
        if (!0x1::string::is_empty(&v4)) {
            let v11 = arg2 * (arg0.v_ref as u64) / 10000;
            v10 = v11;
            send_to_village(arg0, v4, v11, arg4);
        };
        let v12 = ClaimToken{
            user_address            : arg1,
            amount_user_received    : v1,
            ref1_address            : v2,
            amount_ref1_received    : v5,
            ref2_address            : v3,
            amount_ref2_received    : v6,
            village_id              : v4,
            amount_village_received : v10,
        };
        0x2::event::emit<ClaimToken>(v12);
    }

    public fun auth_upgrade_seafood(arg0: &mut 0x2::object::UID, arg1: &mut GameInfo, arg2: u8, arg3: address) : u8 {
        assert!(arg1.version <= 1, 2);
        assert!(is_authorized(arg0), 18);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg1.id, arg3), 5);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg1.id, arg3);
        let v1 = v0.seafood + arg2;
        assert!((v1 as u64) <= 0x2::table_vec::length<SeafoodLevel>(&arg1.seafood_level) - 1, 7);
        v0.seafood = v1;
        let v2 = UpgradeLevel{
            type           : 2,
            user_address   : arg3,
            level          : (v1 as u16),
            amount_upgrade : 0,
        };
        0x2::event::emit<UpgradeLevel>(v2);
        v1
    }

    public fun authorize_app(arg0: &OwnerCap, arg1: &mut 0x2::object::UID) {
        let v0 = AppKey{dummy_field: false};
        let v1 = AppAuthInfo{auth_type: 1};
        0x2::dynamic_field::add<AppKey, AppAuthInfo>(arg1, v0, v1);
    }

    entry fun claim(arg0: &mut GameInfo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        inner_claim(arg0, v0, false, arg1, arg2);
    }

    entry fun create_user(arg0: &mut GameInfo, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x1::string::utf8(b"CREATE_USER:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 3);
        assert!(!0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 4);
        if (!0x1::string::is_empty(&arg3)) {
            assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg3), 13);
            let v2 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg0.id, arg3);
            v2.num_of_members = v2.num_of_members + 1;
        };
        let v3 = User{
            id                       : 0x2::object::new(arg6),
            boat                     : 0,
            mesh                     : 0,
            seafood                  : 0,
            special_boost            : 0x1::option::none<u16>(),
            special_boost_start_time : 0,
            village                  : arg3,
            referral                 : arg2,
            last_claim               : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::dynamic_object_field::add<address, User>(&mut arg0.id, arg1, v3);
        let v4 = arg0.init_reward;
        let v5 = CreateUser{
            user_address : arg1,
            ref_address  : arg2,
            init_reward  : v4,
            village_id   : arg3,
        };
        0x2::event::emit<CreateUser>(v5);
        if (v4 > 0) {
            allocate_tokens(arg0, arg1, v4, false, arg6);
        };
    }

    entry fun create_village(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x1::string::utf8(b"CREATE_VILLAGE:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg0.operator_pk, &v1) == true, 3);
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 12);
        let v3 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, arg2);
        assert!(0x1::string::is_empty(&v3.village), 15);
        v3.village = arg1;
        let v4 = Village{
            id             : 0x2::object::new(arg4),
            village_id     : arg1,
            balance        : 0x2::balance::zero<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(),
            owner          : arg2,
            num_of_members : 1,
        };
        0x2::dynamic_object_field::add<0x1::string::String, Village>(&mut arg0.id, arg1, v4);
        let v5 = CreateVillage{
            village_id : arg1,
            owner      : arg2,
        };
        0x2::event::emit<CreateVillage>(v5);
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
        let v22 = @0xfdefe17a05a90060ef50ef578992df05f55ee11d31877d0c3010cbe36781f1b0;
        let v23 = GameInfo{
            id            : 0x2::object::new(arg0),
            version       : 1,
            balance       : 0x2::balance::zero<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(),
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
            v_join_fee    : 50000000000,
            v_leave_fee   : 50000000000,
        };
        0x2::transfer::share_object<GameInfo>(v23);
    }

    fun inner_claim(arg0: &mut GameInfo, arg1: address, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
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
        allocate_tokens(arg0, arg1, v6, arg2, arg4);
    }

    fun inner_join_village(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: address, arg3: address) {
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg2), 5);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 13);
        assert!(arg3 == @0x0 || 0x2::dynamic_object_field::exists_<address>(&arg0.id, arg3), 11);
        let v0 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, arg2);
        assert!(0x1::string::is_empty(&v0.village), 15);
        v0.village = arg1;
        if (arg3 != @0x0 && arg2 != arg3) {
            v0.referral = arg3;
        };
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg0.id, arg1);
        v1.num_of_members = v1.num_of_members + 1;
        let v2 = JoinVillage{
            village_id   : arg1,
            user_address : arg2,
            ref_address  : arg3,
        };
        0x2::event::emit<JoinVillage>(v2);
    }

    public fun is_authorized(arg0: &0x2::object::UID) : bool {
        let v0 = AppKey{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey>(arg0, v0)
    }

    entry fun join_village(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: address, arg3: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg3);
        assert!(v0 >= arg0.v_join_fee, 8);
        let v1 = if (v0 > arg0.v_join_fee) {
            0x2::pay::keep<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg3, arg4);
            0x2::coin::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg3, arg0.v_join_fee, arg4)
        } else {
            arg3
        };
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(v1));
        inner_join_village(arg0, arg1, 0x2::tx_context::sender(arg4), arg2);
    }

    entry fun leave_village(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg1);
        assert!(v1 >= arg0.v_leave_fee, 8);
        let v2 = if (v1 > arg0.v_leave_fee) {
            0x2::pay::keep<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg1, arg2);
            0x2::coin::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg1, arg0.v_leave_fee, arg2)
        } else {
            arg1
        };
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(v2));
        let v3 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0);
        assert!(!0x1::string::is_empty(&v3.village), 14);
        let v4 = v3.village;
        v3.village = 0x1::string::utf8(b"");
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, v4), 13);
        let v5 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg0.id, v4);
        v5.num_of_members = v5.num_of_members - 1;
        let v6 = LeaveVillage{
            village_id   : v4,
            user_address : v0,
        };
        0x2::event::emit<LeaveVillage>(v6);
    }

    entry fun migrate(arg0: &OwnerCap, arg1: &mut GameInfo) {
        assert!(arg1.version < 1, 1);
        arg1.version = 1;
    }

    entry fun remove_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::dynamic_field::remove<0x1::string::String, 0x2::coin::TreasuryCap<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(&mut arg1.id, 0x1::string::utf8(b"treasury")), 0x2::tx_context::sender(arg2));
    }

    public fun revoke_auth(arg0: &OwnerCap, arg1: &mut 0x2::object::UID) {
        let v0 = AppKey{dummy_field: false};
        let AppAuthInfo {  } = 0x2::dynamic_field::remove<AppKey, AppAuthInfo>(arg1, v0);
    }

    fun send_to_village(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 13);
        let v0 = 0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg0.id, arg1).balance, 0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance, arg2));
        } else if (v0 > 0) {
            0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg0.id, arg1).balance, 0x2::balance::withdraw_all<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance));
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg0.id, arg1).balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::coin::mint<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3)));
        };
    }

    fun send_tokens(arg0: &mut GameInfo, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg0.balance);
        let v1 = 0;
        if (v0 >= arg2) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance, arg2), arg3), arg1);
        } else if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::withdraw_all<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance), arg3), arg1);
            v1 = arg2 - v0;
        } else {
            v1 = arg2;
        };
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::mint<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::coin::TreasuryCap<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(&mut arg0.id, 0x1::string::utf8(b"treasury")), v1, arg3), arg1);
        };
    }

    entry fun send_village_token(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x1::string::String, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version <= 1, 2);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg1.id, arg2), 13);
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, Village>(&mut arg1.id, arg2);
        let v1 = 0x2::balance::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&v0.balance);
        assert!(v1 >= arg3, 16);
        if (v1 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v0.balance, arg3), arg5), arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>>(0x2::coin::from_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(0x2::balance::withdraw_all<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut v0.balance), arg5), arg4);
        };
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

    entry fun system_claim(arg0: &mut GameInfo, arg1: address, arg2: bool, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x1::string::utf8(b"SYS_CLAIM:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg3));
        assert!(0x2::ed25519::ed25519_verify(&arg4, &arg0.operator_pk, &v1) == true, 3);
        assert!(0x2::clock::timestamp_ms(arg5) < arg3, 9);
        inner_claim(arg0, arg1, arg2, arg5, arg6);
    }

    entry fun system_join_village(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &0x2::clock::Clock) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x1::string::utf8(b"JOIN_VILLAGE:");
        let v1 = 0x2::bcs::to_bytes<0x1::string::String>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&arg1));
        let v2 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg2));
        let v3 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v3));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg3));
        let v4 = 0x1::string::utf8(b"-");
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x1::string::String>(&v4));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg4));
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg0.operator_pk, &v1) == true, 3);
        assert!(0x2::clock::timestamp_ms(arg6) < arg4, 9);
        inner_join_village(arg0, arg1, arg2, arg3);
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
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg1, 17);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, arg1), 11);
        0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0).referral = arg1;
        let v1 = UpdateRef{
            user_address : v0,
            new_ref      : arg1,
        };
        0x2::event::emit<UpdateRef>(v1);
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

    entry fun update_village(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: u16, arg3: u64, arg4: u64) {
        assert!(arg2 <= 10000, 10);
        arg1.v_ref = arg2;
        arg1.v_join_fee = arg3;
        arg1.v_leave_fee = arg4;
    }

    entry fun upgrade_boat(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0);
        let v2 = v1.boat + 1;
        assert!((v2 as u64) <= 0x2::table_vec::length<BoatLevel>(&arg0.boat_level) - 1, 7);
        let v3 = 0x2::table_vec::borrow<BoatLevel>(&arg0.boat_level, (v1.boat as u64));
        let v4 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg1);
        assert!(v4 >= v3.price_upgrade, 8);
        let v5 = if (v4 > v3.price_upgrade) {
            0x2::pay::keep<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg1, arg2);
            0x2::coin::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg1, v3.price_upgrade, arg2)
        } else {
            arg1
        };
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(v5));
        v1.boat = v2;
        let v6 = UpgradeLevel{
            type           : 0,
            user_address   : v0,
            level          : (v2 as u16),
            amount_upgrade : v3.price_upgrade,
        };
        0x2::event::emit<UpgradeLevel>(v6);
    }

    entry fun upgrade_mesh(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version <= 1, 2);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::dynamic_object_field::exists_<address>(&arg0.id, v0), 5);
        let v1 = 0x2::dynamic_object_field::borrow_mut<address, User>(&mut arg0.id, v0);
        let v2 = v1.mesh + 1;
        assert!((v2 as u64) <= 0x2::table_vec::length<MeshLevel>(&arg0.mesh_level) - 1, 7);
        let v3 = 0x2::table_vec::borrow<MeshLevel>(&arg0.mesh_level, (v1.mesh as u64));
        let v4 = 0x2::coin::value<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&arg1);
        assert!(v4 >= v3.price_upgrade, 8);
        let v5 = if (v4 > v3.price_upgrade) {
            0x2::pay::keep<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(arg1, arg2);
            0x2::coin::split<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg1, v3.price_upgrade, arg2)
        } else {
            arg1
        };
        0x2::balance::join<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(&mut arg0.balance, 0x2::coin::into_balance<0xa8816d3a6e3136e86bc2873b1f94a15cadc8af2703c075f2d546c2ae367f4df9::ocean::OCEAN>(v5));
        v1.mesh = v2;
        let v6 = UpgradeLevel{
            type           : 1,
            user_address   : v0,
            level          : (v2 as u16),
            amount_upgrade : v3.price_upgrade,
        };
        0x2::event::emit<UpgradeLevel>(v6);
    }

    entry fun upgrade_seafood(arg0: &mut GameInfo, arg1: u8, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg0.version <= 1, 2);
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
            type           : 2,
            user_address   : arg2,
            level          : (arg1 as u16),
            amount_upgrade : 0,
        };
        0x2::event::emit<UpgradeLevel>(v4);
    }

    entry fun upgrade_special_boost(arg0: &mut GameInfo, arg1: u16, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        assert!(arg0.version <= 1, 2);
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
            type           : 3,
            user_address   : arg2,
            level          : arg1,
            amount_upgrade : 0,
        };
        0x2::event::emit<UpgradeLevel>(v6);
    }

    // decompiled from Move bytecode v6
}

