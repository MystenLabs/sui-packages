module 0x3298f2f36693c824ebcefcdc69c3c7225bd23270f9f343ce248654bcbcab372e::TRUMUP {
    struct TRUMUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMUP>(arg0, 9, b"TRUMUP", b"TRUMUP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMUP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMUP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMUP>>(0x2::coin::mint<TRUMUP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

