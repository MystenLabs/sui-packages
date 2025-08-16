module 0x92f554620b26edcc7283f9cbc4b940d959b43f3fd915c818ba68b224695d86ee::hotpot {
    struct HOTPOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTPOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTPOT>(arg0, 9, b"HOTPOT", b"hotpot", b"11:35", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://picsum.photos/200/300")), arg1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<HOTPOT>>(v0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTPOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

