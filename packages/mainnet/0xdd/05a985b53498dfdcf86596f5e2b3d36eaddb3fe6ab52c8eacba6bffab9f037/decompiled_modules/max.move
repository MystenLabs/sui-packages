module 0xdd05a985b53498dfdcf86596f5e2b3d36eaddb3fe6ab52c8eacba6bffab9f037::max {
    struct MAX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MAX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<MAX>(arg0) < 1000000000000000, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<MAX>>(0x2::coin::mint<MAX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAX>(arg0, 9, b"MAXTICKER", b"MAX", b"testing max supply", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

