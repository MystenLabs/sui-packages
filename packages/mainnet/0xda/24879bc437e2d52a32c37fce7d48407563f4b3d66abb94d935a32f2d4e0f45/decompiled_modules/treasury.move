module 0xda24879bc437e2d52a32c37fce7d48407563f4b3d66abb94d935a32f2d4e0f45::treasury {
    struct Stage<phantom T0> has copy, drop, store {
        timeshift_ms: u64,
        number_of_epochs: u64,
        epoch_duration_ms: u64,
        pools: vector<0x1::string::String>,
        amounts: vector<u64>,
    }

    struct ScheduleEntry<phantom T0> has drop, store {
        start_time_ms: 0x1::option::Option<u64>,
        current_epoch: u64,
        stage: Stage<T0>,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        max_supply: u64,
        schedule: vector<ScheduleEntry<T0>>,
        cap: 0x2::coin::TreasuryCap<T0>,
        current_entry: u64,
    }

    public(friend) fun mint<T0>(arg0: &mut Treasury<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (vector<0x1::string::String>, vector<0x2::coin::Coin<T0>>) {
        assert!(0x1::vector::length<ScheduleEntry<T0>>(&arg0.schedule) > 0, 0);
        assert!(arg0.current_entry < 0x1::vector::length<ScheduleEntry<T0>>(&arg0.schedule), 0);
        assert!(!0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, b"mint_blocked"), 4);
        let v0 = 0x1::vector::borrow_mut<ScheduleEntry<T0>>(&mut arg0.schedule, arg0.current_entry);
        let v1 = &mut arg0.cap;
        let (v2, v3) = mint_entry<T0>(v0, arg0.max_supply, v1, arg1, arg2);
        if (v0.current_epoch == v0.stage.number_of_epochs) {
            arg0.current_entry = arg0.current_entry + 1;
            if (arg0.current_entry < 0x1::vector::length<ScheduleEntry<T0>>(&arg0.schedule)) {
                let v4 = 0x1::vector::borrow_mut<ScheduleEntry<T0>>(&mut arg0.schedule, arg0.current_entry);
                v4.start_time_ms = 0x1::option::some<u64>(get_entry_mint_time<T0>(v0) + v4.stage.timeshift_ms);
            };
        };
        (v2, v3)
    }

    public(friend) fun create<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: u64, arg2: vector<ScheduleEntry<T0>>, arg3: &mut 0x2::tx_context::TxContext) : Treasury<T0> {
        let v0 = Treasury<T0>{
            id            : 0x2::object::new(arg3),
            max_supply    : arg1,
            schedule      : arg2,
            cap           : arg0,
            current_entry : 0,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut v0.id, b"mint_blocked", true);
        v0
    }

    public(friend) fun create_entry<T0>(arg0: vector<0x1::string::String>, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: u64) : ScheduleEntry<T0> {
        assert!(0x1::vector::length<0x1::string::String>(&arg0) == 0x1::vector::length<u64>(&arg1), 1);
        assert!(arg2 > 0, 1);
        assert!(arg3 > 0, 1);
        let v0 = Stage<T0>{
            timeshift_ms      : arg4,
            number_of_epochs  : arg2,
            epoch_duration_ms : arg3,
            pools             : arg0,
            amounts           : arg1,
        };
        ScheduleEntry<T0>{
            start_time_ms : 0x1::option::none<u64>(),
            current_epoch : 0,
            stage         : v0,
        }
    }

    fun get_entry_mint_time<T0>(arg0: &ScheduleEntry<T0>) : u64 {
        0x1::option::get_with_default<u64>(&arg0.start_time_ms, 0) + arg0.stage.timeshift_ms + arg0.current_epoch * arg0.stage.epoch_duration_ms
    }

    public(friend) fun insert_entry<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: ScheduleEntry<T0>) {
        assert!(arg1 <= 0x1::vector::length<ScheduleEntry<T0>>(&arg0.schedule), 3);
        assert!(arg0.current_entry == 0 || arg1 > arg0.current_entry, 3);
        0x1::vector::insert<ScheduleEntry<T0>>(&mut arg0.schedule, arg2, arg1);
    }

    fun mint_entry<T0>(arg0: &mut ScheduleEntry<T0>, arg1: u64, arg2: &mut 0x2::coin::TreasuryCap<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (vector<0x1::string::String>, vector<0x2::coin::Coin<T0>>) {
        if (0x1::option::is_none<u64>(&arg0.start_time_ms)) {
            arg0.start_time_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
        };
        assert!(0x2::clock::timestamp_ms(arg3) >= get_entry_mint_time<T0>(arg0), 2);
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::coin::Coin<T0>>();
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.stage.pools)) {
            let v2 = *0x1::vector::borrow<u64>(&arg0.stage.amounts, v0);
            assert!(v2 <= arg1 - 0x2::coin::total_supply<T0>(arg2), 0);
            0x1::vector::push_back<0x2::coin::Coin<T0>>(&mut v1, 0x2::coin::mint<T0>(arg2, v2, arg4));
            v0 = v0 + 1;
        };
        arg0.current_epoch = arg0.current_epoch + 1;
        (arg0.stage.pools, v1)
    }

    public(friend) fun premint<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.cap, arg1, arg2)
    }

    public(friend) fun remove_entry<T0>(arg0: &mut Treasury<T0>, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<ScheduleEntry<T0>>(&arg0.schedule), 3);
        assert!(arg0.current_entry == 0 || arg1 > arg0.current_entry, 3);
        0x1::vector::remove<ScheduleEntry<T0>>(&mut arg0.schedule, arg1);
    }

    public(friend) fun set_entry<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: ScheduleEntry<T0>) {
        assert!(arg1 < 0x1::vector::length<ScheduleEntry<T0>>(&arg0.schedule), 3);
        assert!(arg1 >= arg0.current_entry, 3);
        let v0 = 0x1::vector::borrow_mut<ScheduleEntry<T0>>(&mut arg0.schedule, arg1);
        if (arg0.current_entry == arg1) {
            assert!(arg2.stage.number_of_epochs > v0.current_epoch, 1);
        };
        v0.stage = arg2.stage;
    }

    public(friend) fun unblock_minting<T0>(arg0: &mut Treasury<T0>) {
        0x2::dynamic_field::remove_if_exists<vector<u8>, bool>(&mut arg0.id, b"mint_blocked");
    }

    // decompiled from Move bytecode v6
}

