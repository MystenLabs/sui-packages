module 0x16864f9a8c523bc422069c46bfdac140d03e71970dd59408b708d05343bad4ad::susi {
    struct SUSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSI>(arg0, 6, b"Susi", b"Suisaki", x"42726f207468696e6b73206865277320696e206120747261696e696e67206172630a2249206469646e2774206c6f7365206d6f6e65792c2049206a75737420626f7567687420657870657269656e63652e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738316869635.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

