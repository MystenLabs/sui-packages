module 0x2690e8ede3ca0401ee9a9b21a2e807a217fc4a472ca0cafbc35bf41804b807f::trung {
    struct TRUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUNG>(arg0, 9, b"TRUNG", b"Torung", b"Trung pt", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32c7e389-3b78-4520-946a-383a1ce51a7c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

