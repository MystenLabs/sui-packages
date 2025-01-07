module 0x6d8c747402ea6e3ec08e968e48033e3813a801ca67680a6c3275a13ed78db296::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 6, b"MARIE", b"Marie Rose", b"Just launched Marie Rose - Official Mascot of SPX6900 on Sui after successful listing on ETH! (Developer LP will be Burnt)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mariespx_26aba54a2a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

