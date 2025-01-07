module 0xd69dc6fdaaf6b77634c3f33d61feed0c6179260b1c9b2a980f6fa391a7c0faf2::dogesui {
    struct DOGESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGESUI>(arg0, 9, b"DOGESUI", b"Doge sui t", b"Doge crypto in sui platform.good luck.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a21cbea1-1d52-4d16-ac00-e522284aba4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

