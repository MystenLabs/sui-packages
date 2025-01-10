module 0x92e8eeac8ac5ba87975a3af603444e13b1da08abccfa40285ccd160583e2a663::sgpfp {
    struct SGPFP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGPFP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGPFP>(arg0, 6, b"SGPFP", b"Squid Game PFP Agent", b"SQUID GAME PFP is a token-inspired project that revolves around a profile picture generator themed after the hit series Squid Game. It embodies creativity, suspense, and individuality, capturing the essence of the show while adding a unique personal ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736514193713.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGPFP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGPFP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

