module 0xde32b86d1f73c49a3b939c900272ccafb3a88ad219500027ad66dbda35de9dbd::oggs {
    struct OGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGS>(arg0, 6, b"OggS", b"Oggy Sui", b"We will figure out how to get the project to expand like $PEPE. Tele: https://t.me/Oggy_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/tCLar8U.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x1181a4669074aaf564a21d1dcb592bf812c7067ed4fd3d7b1a1b3701ff16f9c4;
        0x2::coin::mint_and_transfer<OGGS>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGS>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

