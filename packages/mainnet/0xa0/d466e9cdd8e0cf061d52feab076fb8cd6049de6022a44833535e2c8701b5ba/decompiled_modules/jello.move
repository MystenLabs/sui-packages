module 0xa0d466e9cdd8e0cf061d52feab076fb8cd6049de6022a44833535e2c8701b5ba::jello {
    struct JELLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLO>(arg0, 9, b"JELLO", b"Jelly Iota", b"what a great freaking project, right?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JELLO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JELLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

