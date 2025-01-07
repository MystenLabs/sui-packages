module 0xc8335bb19c484dc2049270777e23d9ea7ce3caf1453b1d889c5071d18859076d::tbaf {
    struct TBAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TBAF>(arg0, 9, b"TBAF", b"bdbd", b"ndb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/147c42ca-4ee2-43c4-8542-988493928df3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TBAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

