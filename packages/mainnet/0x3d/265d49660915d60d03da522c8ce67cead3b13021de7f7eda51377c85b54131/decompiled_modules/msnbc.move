module 0x3d265d49660915d60d03da522c8ce67cead3b13021de7f7eda51377c85b54131::msnbc {
    struct MSNBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSNBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MSNBC>(arg0, 6, b"MSNBC", b"M$NBC", b"We are thrilled about your interest in the MSNBC Insights Community; an exclusive group of individuals who answer online surveys and provide access to give feedback directly to MSNBC show producers and upper management about its TV shows and digital ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732510530550.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MSNBC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSNBC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

