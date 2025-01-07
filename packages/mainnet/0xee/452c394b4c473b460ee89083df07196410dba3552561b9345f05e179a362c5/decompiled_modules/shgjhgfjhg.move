module 0xee452c394b4c473b460ee89083df07196410dba3552561b9345f05e179a362c5::shgjhgfjhg {
    struct SHGJHGFJHG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHGJHGFJHG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHGJHGFJHG>(arg0, 9, b"SHGJHGFJHG", b"jfjf", b"hgjhgjhgk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce7178f2-b7fa-4da2-94c7-bee6a21a2eea.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHGJHGFJHG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHGJHGFJHG>>(v1);
    }

    // decompiled from Move bytecode v6
}

