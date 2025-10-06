module 0x3cebf157c3595b2b5a590a506c60128506237d889917a0f7317a2c7bf6ed0289::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct BoostingTier has copy, drop, store {
        point: u64,
        duration: u64,
        original_amount: u64,
        amount: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        tiers: 0x2::vec_map::VecMap<u64, BoostingTier>,
        fee_receiver: address,
    }

    public fun add_tier(arg0: &mut Config, arg1: &0x3cebf157c3595b2b5a590a506c60128506237d889917a0f7317a2c7bf6ed0289::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg4 > 0, 104);
        assert!(arg6 > 0, 105);
        assert!(arg3 > 0, 106);
        assert!(arg5 > 0, 107);
        let v0 = BoostingTier{
            point           : arg3,
            duration        : arg4,
            original_amount : arg5,
            amount          : arg6,
        };
        0x2::vec_map::insert<u64, BoostingTier>(&mut arg0.tiers, arg2, v0);
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 103);
        let v0 = Config{
            id           : 0x2::object::new(arg1),
            tiers        : 0x2::vec_map::empty<u64, BoostingTier>(),
            fee_receiver : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun get_fee_receiver(arg0: &Config) : address {
        arg0.fee_receiver
    }

    public fun get_tier(arg0: &Config, arg1: u64) : BoostingTier {
        *0x2::vec_map::get<u64, BoostingTier>(&arg0.tiers, &arg1)
    }

    public fun get_tier_amount(arg0: &BoostingTier) : u64 {
        arg0.amount
    }

    public fun get_tier_duration(arg0: &BoostingTier) : u64 {
        arg0.duration
    }

    public fun get_tier_original_amount(arg0: &BoostingTier) : u64 {
        arg0.original_amount
    }

    public fun get_tier_point(arg0: &BoostingTier) : u64 {
        arg0.point
    }

    public fun get_tiers(arg0: &Config) : &0x2::vec_map::VecMap<u64, BoostingTier> {
        &arg0.tiers
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun remove_tier(arg0: &mut Config, arg1: &0x3cebf157c3595b2b5a590a506c60128506237d889917a0f7317a2c7bf6ed0289::admin::AdminCap, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, BoostingTier>(&arg0.tiers, &arg2), 102);
        let (_, _) = 0x2::vec_map::remove<u64, BoostingTier>(&mut arg0.tiers, &arg2);
    }

    public fun update_fee_receiver(arg0: &mut Config, arg1: &0x3cebf157c3595b2b5a590a506c60128506237d889917a0f7317a2c7bf6ed0289::admin::AdminCap, arg2: address) {
        arg0.fee_receiver = arg2;
    }

    public fun update_tier(arg0: &mut Config, arg1: &0x3cebf157c3595b2b5a590a506c60128506237d889917a0f7317a2c7bf6ed0289::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg3 > 0, 104);
        assert!(arg4 > 0, 105);
        assert!(arg5 > 0, 106);
        assert!(arg6 > 0, 107);
        let (_, _) = 0x2::vec_map::remove<u64, BoostingTier>(&mut arg0.tiers, &arg2);
        let v2 = BoostingTier{
            point           : arg5,
            duration        : arg3,
            original_amount : arg6,
            amount          : arg4,
        };
        0x2::vec_map::insert<u64, BoostingTier>(&mut arg0.tiers, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

