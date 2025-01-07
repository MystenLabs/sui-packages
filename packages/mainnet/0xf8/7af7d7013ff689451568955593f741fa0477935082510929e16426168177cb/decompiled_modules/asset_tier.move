module 0xf87af7d7013ff689451568955593f741fa0477935082510929e16426168177cb::asset_tier {
    struct AssetTierKey<phantom T0> has copy, drop, store {
        name: 0x1::string::String,
    }

    struct AssetTier<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        duration: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AssetTier<T0> {
        AssetTier<T0>{
            id       : 0x2::object::new(arg2),
            amount   : arg0,
            duration : arg1,
        }
    }

    public fun amount<T0>(arg0: &AssetTier<T0>) : u64 {
        arg0.amount
    }

    public fun duration<T0>(arg0: &AssetTier<T0>) : u64 {
        arg0.duration
    }

    public fun new_asset_tier_key<T0>(arg0: 0x1::string::String) : AssetTierKey<T0> {
        AssetTierKey<T0>{name: arg0}
    }

    public(friend) fun update<T0>(arg0: &mut AssetTier<T0>, arg1: u64, arg2: u64) {
        arg0.amount = arg1;
        arg0.duration = arg2;
    }

    // decompiled from Move bytecode v6
}

