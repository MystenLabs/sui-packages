module 0xee00d046ce791e102996a055f245e13ddd05f4f88c0ac41e37aa56e9ac099462::belbotbsui {
    struct BELBOTBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELBOTBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELBOTBSUI>(arg0, 9, b"BELBOTBSUI", b"btcethltcbushobamatrumpbidensui", b"https://t.me/btcethltcbushobamatrumpbidensui http://btcethltcbushobamatrumpbidensui.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BELBOTBSUI>(&mut v2, 1600000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELBOTBSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BELBOTBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

