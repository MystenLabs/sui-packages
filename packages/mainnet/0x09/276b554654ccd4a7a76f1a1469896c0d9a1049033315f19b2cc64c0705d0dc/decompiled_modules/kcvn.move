module 0x9276b554654ccd4a7a76f1a1469896c0d9a1049033315f19b2cc64c0705d0dc::kcvn {
    struct KCVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCVN>(arg0, 9, b"KCVN", b"KINGCOINS", b"Token of Kingcoins Vietnam: https://t.me/kingcoins_vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c98ee86b-e61c-4c76-842e-8c0894da2fb9-IMG_20231016_203641_787.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

