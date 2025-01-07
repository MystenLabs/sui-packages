module 0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::lock_coin {
    struct DemandCap has key {
        id: 0x2::object::UID,
        item_id: 0x2::object::ID,
    }

    struct Lock has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        total_lock: u64,
        total_unlock: u64,
        lock_coin: 0x2::coin::Coin<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>,
        start_time: u64,
    }

    struct TGE has store, key {
        id: 0x2::object::UID,
        percentage: u8,
    }

    struct Vesting has store, key {
        id: 0x2::object::UID,
        start_time: u64,
        end_time: u64,
        linear_day: u16,
    }

    struct Demand has store, key {
        id: 0x2::object::UID,
        amount: vector<u64>,
        start_time: vector<u64>,
    }

    struct TokenomicCap has key {
        id: 0x2::object::UID,
        initialize: bool,
    }

    struct CreateLockEvent has copy, drop {
        lock_id: 0x2::object::ID,
        total_lock: u64,
        total_unlock: u64,
        start_time: u64,
        owner: address,
    }

    struct ClaimTokenomicEvent has copy, drop {
        lock_id: 0x2::object::ID,
        receiver: address,
        unlock_amount: u64,
        unlock_at: u64,
    }

    struct AddTgeEvent has copy, drop {
        lock_id: 0x2::object::ID,
        percentage: u8,
    }

    struct AddVestingEvent has copy, drop {
        lock_id: 0x2::object::ID,
        start_time: u64,
        end_time: u64,
        linear_day: u16,
    }

    struct AddDemandEvent has copy, drop {
        lock_id: 0x2::object::ID,
        demand_amount: u64,
        unlock_demand_at: u64,
    }

    struct RemoveDemandEvent has copy, drop {
        lock_id: 0x2::object::ID,
        index: u64,
    }

    struct LOCK_COIN has drop {
        dummy_field: bool,
    }

    public fun add_demand(arg0: &mut Lock, arg1: &mut DemandCap, arg2: u64, arg3: u64) {
        assert!(arg1.item_id == 0x2::object::uid_to_inner(&arg0.id), 405);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Demand>(&mut arg0.id, b"Demand");
        0x1::vector::push_back<u64>(&mut v0.amount, arg2);
        0x1::vector::push_back<u64>(&mut v0.start_time, arg3);
        let v1 = AddDemandEvent{
            lock_id          : 0x2::object::id<Lock>(arg0),
            demand_amount    : arg2,
            unlock_demand_at : arg3,
        };
        0x2::event::emit<AddDemandEvent>(v1);
    }

    fun add_demand_dof(arg0: &mut Lock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Demand{
            id         : 0x2::object::new(arg1),
            amount     : 0x1::vector::empty<u64>(),
            start_time : 0x1::vector::empty<u64>(),
        };
        0x2::dynamic_object_field::add<vector<u8>, Demand>(&mut arg0.id, b"Demand", v0);
    }

    fun add_tge(arg0: &mut Lock, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TGE{
            id         : 0x2::object::new(arg2),
            percentage : arg1,
        };
        0x2::dynamic_object_field::add<vector<u8>, TGE>(&mut arg0.id, b"TGE", v0);
        let v1 = AddTgeEvent{
            lock_id    : 0x2::object::id<Lock>(arg0),
            percentage : arg1,
        };
        0x2::event::emit<AddTgeEvent>(v1);
    }

    fun add_vesting(arg0: &mut Lock, arg1: u64, arg2: u64, arg3: u16, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Vesting{
            id         : 0x2::object::new(arg4),
            start_time : arg1,
            end_time   : arg2,
            linear_day : arg3,
        };
        0x2::dynamic_object_field::add<vector<u8>, Vesting>(&mut arg0.id, b"Vesting", v0);
        let v1 = AddVestingEvent{
            lock_id    : 0x2::object::id<Lock>(arg0),
            start_time : arg1,
            end_time   : arg2,
            linear_day : arg3,
        };
        0x2::event::emit<AddVestingEvent>(v1);
    }

    public fun calculate_maximum_earn(arg0: &Lock, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = v0;
        let v2 = arg0.total_lock;
        let v3 = arg0.total_lock;
        let v4 = 0x2::clock::timestamp_ms(arg1);
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"TGE")) {
            let v5 = 0x2::dynamic_object_field::borrow<vector<u8>, TGE>(&arg0.id, b"TGE");
            if (v5.percentage > 0) {
                v1 = v0 + v2 * (v5.percentage as u64) / 100;
                v3 = v2 * (100 - (v5.percentage as u64)) / 100;
            };
        };
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"Demand")) {
            let v6 = 0x2::dynamic_object_field::borrow<vector<u8>, Demand>(&arg0.id, b"Demand");
            let v7 = v6.amount;
            let v8 = v6.start_time;
            while (!0x1::vector::is_empty<u64>(&v7)) {
                let v9 = 0x1::vector::pop_back<u64>(&mut v7);
                if (v4 >= 0x1::vector::pop_back<u64>(&mut v8)) {
                    v1 = v1 + v9;
                    v3 = v3 - v9;
                };
            };
        };
        if (0x2::dynamic_object_field::exists_<vector<u8>>(&arg0.id, b"Vesting")) {
            let v10 = 0x2::dynamic_object_field::borrow<vector<u8>, Vesting>(&arg0.id, b"Vesting");
            if (v4 >= v10.end_time) {
                v1 = v1 + v3;
            } else if (v4 < v10.start_time) {
                v1 = v1 + 0;
            } else if (v4 < v10.end_time && v4 > v10.start_time) {
                v1 = v1 + v3 * (v4 - v10.start_time) / (v10.linear_day as u64) * 86400000 / (v10.end_time - v10.start_time) / (v10.linear_day as u64) * 86400000;
            };
        };
        v1 - arg0.total_unlock
    }

    public entry fun claim(arg0: &mut Lock, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = calculate_maximum_earn(arg0, arg1);
        assert!(v0 > 0, 305);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>>(0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(&mut arg0.lock_coin, v0, arg2), 0x2::tx_context::sender(arg2));
        arg0.total_unlock = arg0.total_unlock + v0;
        let v1 = ClaimTokenomicEvent{
            lock_id       : 0x2::object::id<Lock>(arg0),
            receiver      : 0x2::tx_context::sender(arg2),
            unlock_amount : v0,
            unlock_at     : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<ClaimTokenomicEvent>(v1);
    }

    fun create_lock(arg0: 0x2::coin::Coin<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>, arg1: vector<u8>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : Lock {
        let v0 = 0x2::coin::value<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(&arg0);
        let v1 = 1682874000000;
        let v2 = Lock{
            id           : 0x2::object::new(arg3),
            name         : 0x1::string::utf8(arg1),
            total_lock   : v0,
            total_unlock : 0,
            lock_coin    : arg0,
            start_time   : v1,
        };
        let v3 = CreateLockEvent{
            lock_id      : 0x2::object::id<Lock>(&v2),
            total_lock   : v0,
            total_unlock : 0,
            start_time   : v1,
            owner        : arg2,
        };
        0x2::event::emit<CreateLockEvent>(v3);
        v2
    }

    fun init(arg0: LOCK_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenomicCap{
            id         : 0x2::object::new(arg1),
            initialize : false,
        };
        0x2::transfer::transfer<TokenomicCap>(v0, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<LOCK_COIN>(arg0, arg1);
    }

    public entry fun init_tokenomic(arg0: &mut TokenomicCap, arg1: &mut 0x2::coin::Coin<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>, arg2: &0x2::coin::CoinMetadata<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.initialize == false, 403);
        let v0 = 0x2::coin::get_decimals<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg2);
        let v1 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 78000000 * 0x2::math::pow(10, v0), arg3);
        let v2 = create_lock(v1, b"Team", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v3 = &mut v2;
        add_vesting(v3, 1746032400000, 1777568400000, 7, arg3);
        0x2::transfer::transfer<Lock>(v2, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v4 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 126000000 * 0x2::math::pow(10, v0), arg3);
        let v5 = create_lock(v4, b"Staking/Farming", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v6 = DemandCap{
            id      : 0x2::object::new(arg3),
            item_id : 0x2::object::id<Lock>(&v5),
        };
        0x2::transfer::transfer<DemandCap>(v6, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v7 = &mut v5;
        add_tge(v7, 50, arg3);
        let v8 = &mut v5;
        add_demand_dof(v8, arg3);
        0x2::transfer::transfer<Lock>(v5, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v9 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 144000000 * 0x2::math::pow(10, v0), arg3);
        let v10 = create_lock(v9, b"Game/Rewards", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v11 = DemandCap{
            id      : 0x2::object::new(arg3),
            item_id : 0x2::object::id<Lock>(&v10),
        };
        0x2::transfer::transfer<DemandCap>(v11, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v12 = &mut v10;
        add_demand_dof(v12, arg3);
        0x2::transfer::transfer<Lock>(v10, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v13 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 66000000 * 0x2::math::pow(10, v0), arg3);
        let v14 = create_lock(v13, b"Treasury", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v15 = DemandCap{
            id      : 0x2::object::new(arg3),
            item_id : 0x2::object::id<Lock>(&v14),
        };
        0x2::transfer::transfer<DemandCap>(v15, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v16 = &mut v14;
        add_demand_dof(v16, arg3);
        0x2::transfer::transfer<Lock>(v14, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v17 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 42000000 * 0x2::math::pow(10, v0), arg3);
        let v18 = create_lock(v17, b"Private Sale", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v19 = &mut v18;
        add_vesting(v19, 1725123600000, 1756659600000, 7, arg3);
        0x2::transfer::transfer<Lock>(v18, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v20 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 48000000 * 0x2::math::pow(10, v0), arg3);
        let v21 = create_lock(v20, b"Airdrop", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v22 = &mut v21;
        add_tge(v22, 50, arg3);
        let v23 = &mut v21;
        add_vesting(v23, 1682874000000, 1685552400000, 7, arg3);
        0x2::transfer::transfer<Lock>(v21, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v24 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 36000000 * 0x2::math::pow(10, v0), arg3);
        let v25 = create_lock(v24, b"Launchpad Sale", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v26 = &mut v25;
        add_tge(v26, 100, arg3);
        0x2::transfer::transfer<Lock>(v25, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        let v27 = 0x2::coin::split<0xfedb441509756e72f20826b476a94f0392f978d1a25f462aadd2524c33ccd1b8::gruu::GRUU>(arg1, 60000000 * 0x2::math::pow(10, v0), arg3);
        let v28 = create_lock(v27, b"Liquidity", @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9, arg3);
        let v29 = &mut v28;
        add_tge(v29, 100, arg3);
        0x2::transfer::transfer<Lock>(v28, @0x2679ea66a3d5db8fba84ba2f96ca4d8b52c679b6b49e22c2d1e3bbce6f4fa9d9);
        arg0.initialize = true;
    }

    public fun remove_demand(arg0: &mut Lock, arg1: &mut DemandCap, arg2: u64) {
        assert!(arg1.item_id == 0x2::object::uid_to_inner(&arg0.id), 405);
        let v0 = 0x2::dynamic_object_field::borrow_mut<vector<u8>, Demand>(&mut arg0.id, b"Demand");
        0x1::vector::remove<u64>(&mut v0.amount, arg2);
        0x1::vector::remove<u64>(&mut v0.start_time, arg2);
        let v1 = RemoveDemandEvent{
            lock_id : 0x2::object::id<Lock>(arg0),
            index   : arg2,
        };
        0x2::event::emit<RemoveDemandEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

