module 0x5759c69e70856e78ed877fd432daa7528a2846f313867185481483a3a82a16f6::bleach {
    struct BLEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEACH>(arg0, 9, b"BLEACH", b"bleach", b"she bleach her asshole", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLEACH>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEACH>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

