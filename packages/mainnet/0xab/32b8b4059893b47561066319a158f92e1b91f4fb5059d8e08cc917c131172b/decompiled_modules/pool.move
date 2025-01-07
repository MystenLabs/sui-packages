module 0xab32b8b4059893b47561066319a158f92e1b91f4fb5059d8e08cc917c131172b::pool {
    struct PoolOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Gift has key {
        id: 0x2::object::UID,
        rewards: 0x2::coin::Coin<0x2::sui::SUI>,
        url: 0x2::url::Url,
    }

    public entry fun CollectRewards(arg0: Gift, arg1: &mut 0x2::tx_context::TxContext) {
        let Gift {
            id      : v0,
            rewards : v1,
            url     : _,
        } = arg0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<PoolOwnerCap>(v0, @0xeecd9e5384ffcf63b67793e2496d2f48fbc195c2009a19d7e715a347e335ec6e);
    }

    public fun new_Gift(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://harlequin-written-whippet-307.mypinata.cloud/ipfs/QmcSxAZTTCyde2rihnJbnEHZTmy2iygzG9QwFZLbGT1gfK/kift.webp";
        let v1 = Gift{
            id      : 0x2::object::new(arg1),
            rewards : arg0,
            url     : 0x2::url::new_unsafe_from_bytes(v0),
        };
        0x2::transfer::transfer<Gift>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

