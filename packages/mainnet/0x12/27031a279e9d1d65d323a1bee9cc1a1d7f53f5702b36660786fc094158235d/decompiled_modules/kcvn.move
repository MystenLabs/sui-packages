module 0x1227031a279e9d1d65d323a1bee9cc1a1d7f53f5702b36660786fc094158235d::kcvn {
    struct KCVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCVN>(arg0, 9, b"KCVN", b"KINGCOINS", b"Token of Kingcoins Vietnam: https://t.me/kingcoins_vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb1765c6-7aef-4af7-ba0b-bc896cd91911-IMG_20231016_203641_787.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

