module 0x390319cb788e96102dec3ea9c1644d8bbe7a668b050a37748664d2f835f990aa::obc {
    struct OBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: OBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OBC>(arg0, 9, b"OBC", b"OBACRYPTO", b"TRADING OF CRYPTOCURRENCY, BUYING AND SELLING OF BTC ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc8505da-34b9-4290-8fcc-f8dce94e1534.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OBC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

