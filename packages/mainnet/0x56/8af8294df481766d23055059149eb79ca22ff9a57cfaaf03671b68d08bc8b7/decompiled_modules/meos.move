module 0x568af8294df481766d23055059149eb79ca22ff9a57cfaaf03671b68d08bc8b7::meos {
    struct MEOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOS>(arg0, 9, b"MEOS", b"MEOMEO", b"Meomeo on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ebed24c0-274f-4c7b-952c-b0df14019605.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

