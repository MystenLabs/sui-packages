module 0x8604fff30cb37d2a88fdc432770931221ebc5641068f30b7693e9c2b4697cfcb::pull {
    struct PULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PULL>(arg0, 9, b"PULL", b"PULL UP", b"PULL UP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PULL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PULL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

