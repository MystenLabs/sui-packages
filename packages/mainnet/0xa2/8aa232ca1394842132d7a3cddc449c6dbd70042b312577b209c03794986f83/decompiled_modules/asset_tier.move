module 0x92d5efc1eec7e45b9e806fbc88ba175555dc605e63fa2db9da2b90b8b68f2e5c::asset_tier {
    struct NewAssetTierEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        amount: u64,
        duration: u64,
        lend_token: 0x1::string::String,
    }

    struct AssetTierKey<phantom T0> has copy, drop, store {
        name: 0x1::string::String,
    }

    struct AssetTier<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
        duration: u64,
    }

    public(friend) fun delete<T0>(arg0: AssetTier<T0>) {
        let AssetTier {
            id       : v0,
            amount   : _,
            duration : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun id<T0>(arg0: &AssetTier<T0>) : 0x2::object::ID {
        0x2::object::id<AssetTier<T0>>(arg0)
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : AssetTier<T0> {
        let v0 = AssetTier<T0>{
            id       : 0x2::object::new(arg4),
            amount   : arg1,
            duration : arg2,
        };
        let v1 = NewAssetTierEvent{
            id         : 0x2::object::id<AssetTier<T0>>(&v0),
            name       : arg0,
            amount     : arg1,
            duration   : arg2,
            lend_token : arg3,
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

