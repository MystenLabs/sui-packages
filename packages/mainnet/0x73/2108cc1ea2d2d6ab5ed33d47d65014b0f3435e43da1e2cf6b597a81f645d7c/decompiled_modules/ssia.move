module 0x732108cc1ea2d2d6ab5ed33d47d65014b0f3435e43da1e2cf6b597a81f645d7c::ssia {
    struct SSIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSIA>(arg0, 9, b"SSIA", b"SSAA", b"SSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSIA>(&mut v2, 400000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSIA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

