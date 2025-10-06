module 0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct BoostingTier has copy, drop, store {
        duration: u64,
        amount: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        tiers: 0x2::vec_map::VecMap<u64, BoostingTier>,
        fee_receiver: address,
    }

    public fun add_tier(arg0: &mut Config, arg1: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg3 > 0, 104);
        assert!(arg4 > 0, 105);
        let v0 = BoostingTier{
            duration : arg3,
            amount   : arg4,
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

    public fun get_tiers(arg0: &Config) : &0x2::vec_map::VecMap<u64, BoostingTier> {
        &arg0.tiers
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun remove_tier(arg0: &mut Config, arg1: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::admin::AdminCap, arg2: u64) {
        assert!(0x2::vec_map::contains<u64, BoostingTier>(&arg0.tiers, &arg2), 102);
        let (_, _) = 0x2::vec_map::remove<u64, BoostingTier>(&mut arg0.tiers, &arg2);
    }

    public fun update_fee_receiver(arg0: &mut Config, arg1: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::admin::AdminCap, arg2: address) {
        arg0.fee_receiver = arg2;
    }

    public fun update_tier(arg0: &mut Config, arg1: &0xd674d54881a1856ff29b303283345032cd63f0f140979865dc9602daf36416b7::admin::AdminCap, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg3 > 0, 104);
        assert!(arg4 > 0, 105);
        let (_, _) = 0x2::vec_map::remove<u64, BoostingTier>(&mut arg0.tiers, &arg2);
        let v2 = BoostingTier{
            duration : arg3,
            amount   : arg4,
        };
        0x2::vec_map::insert<u64, BoostingTier>(&mut arg0.tiers, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

