module 0xa24d41032218db2308e31c50b681b69c92c70e50894e87fcf6040f84a1164a81::johan {
    struct JOHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOHAN>(arg0, 6, b"Johan", b"Johan Liebert", b"Johan Liebert is the main antagonist of Naoki Urasawa psychological thriller manga and anime series", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigwon533k5tucm7l3x5arz453gyqo2frmq6wepsgwombacj5xqmr4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JOHAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

