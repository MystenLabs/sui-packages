module 0x6cd813061a3adf3602b76545f076205f0c8e7ec1d3b1eab9a1da7992c18c0524::vesting_model {
    struct VestingModel has store, key {
        id: 0x2::object::UID,
        cliff: u64,
        vesting_period: u64,
    }

    struct VestingModels has store, key {
        id: 0x2::object::UID,
        models: 0x2::table::Table<0x2::object::ID, VestingModel>,
    }

    public(friend) fun add_model(arg0: &mut VestingModels, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = VestingModel{
            id             : 0x2::object::new(arg3),
            cliff          : arg1,
            vesting_period : arg2,
        };
        let v1 = 0x2::object::id<VestingModel>(&v0);
        0x2::table::add<0x2::object::ID, VestingModel>(&mut arg0.models, v1, v0);
        v1
    }

    public fun calc_vested_amount(arg0: &VestingModels, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<0x2::object::ID, VestingModel>(&arg0.models, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg4) / 1000 - arg3;
        if (v1 <= v0.cliff) {
            return 0
        };
        let v2 = v1 - v0.cliff;
        if (v2 >= v0.vesting_period) {
            return arg2
        };
        mul_div(arg2, v2, v0.vesting_period)
    }

    public fun get_model(arg0: &VestingModels, arg1: 0x2::object::ID) : (&VestingModel, u64, u64) {
        assert!(0x2::table::contains<0x2::object::ID, VestingModel>(&arg0.models, arg1), 701);
        let v0 = 0x2::table::borrow<0x2::object::ID, VestingModel>(&arg0.models, arg1);
        (v0, v0.cliff, v0.vesting_period)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VestingModels{
            id     : 0x2::object::new(arg0),
            models : 0x2::table::new<0x2::object::ID, VestingModel>(arg0),
        };
        0x2::transfer::share_object<VestingModels>(v0);
    }

    public fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 702);
        (v0 as u64)
    }

    public(friend) fun update_model(arg0: &mut VestingModels, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, VestingModel>(&mut arg0.models, arg1);
        v0.cliff = arg2;
        v0.vesting_period = arg3;
    }

    // decompiled from Move bytecode v6
}

