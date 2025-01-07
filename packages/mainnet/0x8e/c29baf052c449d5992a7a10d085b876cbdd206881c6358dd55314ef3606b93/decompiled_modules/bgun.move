module 0x8ec29baf052c449d5992a7a10d085b876cbdd206881c6358dd55314ef3606b93::bgun {
    struct BGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGUN>(arg0, 6, b"BGUN", b"BANANAGUN", x"42414e414e412047554e2069732074686520756c74696d617465206d656d6520636f696e20666f722061706573207769746820697463687920747269676765722066696e6765727321200a0a0a68747470733a2f2f782e636f6d2f61706562616e616e6167756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731013071071.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

