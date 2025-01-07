module 0xc1d151270994f740df9c0125bf6dd833be838880175d3094bf6d66b226fc30a::kcvn {
    struct KCVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCVN>(arg0, 9, b"KCVN", b"KINGCOINS", b"Token of Kingcoins Vietnam: https://t.me/kingcoins_vn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b61fa6fd-2cc7-47d7-af60-6ee6e9fb1d6b-IMG_20231016_203641_787.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

