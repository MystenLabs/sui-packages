module 0x895746884426a12dcda2493afe131a609491194ab4f35b52a011288096328d40::asset_tier {
    struct NewAssetTierEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        amount: u64,
        duration: u64,
    }

    struct AssetTierKey<phantom T0> has copy, drop, store {
        name: 0x1::string::String,
    }

    struct AssetTier<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        duration: u64,
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AssetTier<T0> {
        let v0 = AssetTier<T0>{
            id       : 0x2::object::new(arg3),
            amount   : arg1,
            duration : arg2,
        };
        let v1 = NewAssetTierEvent{
            id       : 0x2::object::id<AssetTier<T0>>(&v0),
            name     : arg0,
            amount   : arg1,
            duration : arg2,
        };
        0x2::event::emit<NewAssetTierEvent>(v1);
        v0
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

