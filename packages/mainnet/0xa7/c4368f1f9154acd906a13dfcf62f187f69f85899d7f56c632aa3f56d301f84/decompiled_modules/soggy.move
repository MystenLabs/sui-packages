module 0xa7c4368f1f9154acd906a13dfcf62f187f69f85899d7f56c632aa3f56d301f84::soggy {
    struct SOGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOGGY>(arg0, 6, b"SOGGY", b"SOGGY Launch 5PM UTC", b"We will figure out how to get the project to expand like $PEPE. Tele: https://t.me/SUIOGGY_news", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/L6vlr2D.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x6657381241f5aa003b5e1782c88b9c3d1ccfb3bf4c16536620bcc6f51456599d;
        0x2::coin::mint_and_transfer<SOGGY>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOGGY>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

