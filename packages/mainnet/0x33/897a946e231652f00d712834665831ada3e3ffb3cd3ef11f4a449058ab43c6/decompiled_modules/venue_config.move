module 0x2d300f3d8819c6e09fd1558e518c2ffab97b324479843d4f94b561b10a441fd0::venue_config {
    struct VenueConfig has key {
        id: 0x2::object::UID,
    }

    struct PoolTierKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct PoolTier has copy, drop, store {
        tick_spacing: u32,
        pool_fee_rate: u64,
    }

    struct PoolTierReserved<phantom T0, phantom T1, phantom T2> has copy, drop {
        tick_spacing: u32,
        pool_fee_rate: u64,
    }

    public(friend) fun object<T0: copy + drop + store, T1: store + key>(arg0: &VenueConfig, arg1: T0) : &T1 {
        0x2::dynamic_object_field::borrow<T0, T1>(&arg0.id, arg1)
    }

    public(friend) fun add_object<T0: copy + drop + store, T1: store + key>(arg0: &mut VenueConfig, arg1: T0, arg2: T1) {
        0x2::dynamic_object_field::add<T0, T1>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun add_pool_tier<T0, T1, T2>(arg0: &mut VenueConfig, arg1: &T2, arg2: u32, arg3: u64) {
        let v0 = PoolTierKey<T0>{dummy_field: false};
        let v1 = PoolTier{
            tick_spacing  : arg2,
            pool_fee_rate : arg3,
        };
        0x2::dynamic_field::add<PoolTierKey<T0>, PoolTier>(&mut arg0.id, v0, v1);
        let v2 = PoolTierReserved<T0, T1, T2>{
            tick_spacing  : arg2,
            pool_fee_rate : arg3,
        };
        0x2::event::emit<PoolTierReserved<T0, T1, T2>>(v2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VenueConfig{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VenueConfig>(v0);
    }

    public(friend) fun pool_tier<T0>(arg0: &VenueConfig) : (u32, u64) {
        let v0 = PoolTierKey<T0>{dummy_field: false};
        let PoolTier {
            tick_spacing  : v1,
            pool_fee_rate : v2,
        } = *0x2::dynamic_field::borrow<PoolTierKey<T0>, PoolTier>(&arg0.id, v0);
        (v1, v2)
    }

    // decompiled from Move bytecode v7
}

