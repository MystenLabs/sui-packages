module 0x825a81d9292a72d1772a43ad5e5bbf33d6b48426ce5ce6a220b93d4368a0d850::alpha {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        owner_id: address,
    }

    struct BurnStartCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id       : 0x2::object::new(arg2),
            owner_id : arg1,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public(friend) fun destroy_start_cap(arg0: BurnStartCap) {
        let BurnStartCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHA>(arg0, 9, b"ALPHA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALPHA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHA>>(0x2::coin::mint<ALPHA>(&mut v2, 1000000000000000, arg1), @0xa511088cc13a632a5e8f9937028a77ae271832465e067360dd13f548fe934d1a);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALPHA>>(0x2::coin::mint<ALPHA>(&mut v2, 500000000000000, arg1), @0xa511088cc13a632a5e8f9937028a77ae271832465e067360dd13f548fe934d1a);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v2, 0x2::tx_context::sender(arg1));
        let v3 = BurnStartCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<BurnStartCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = AdminCap{
            id       : 0x2::object::new(arg1),
            owner_id : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::public_transfer<AdminCap>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

