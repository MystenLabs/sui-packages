module 0x55964710e51d16a5f1212f770a8b919c1462e409f55e78ecaf412962a19362a7::degtyhu {
    struct DEGTYHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGTYHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGTYHU>(arg0, 9, b"DEGTYHU", b"ghghkjtgh", b"bnhdgjy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/05d05734-e086-42ec-8342-d0c4758041a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGTYHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEGTYHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

