module 0x3e0fd37a3eb0eaea63614a6379a0628b97d34f53bf32f6e00ae5c1ca3023314a::oggs {
    struct OGGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGS>(arg0, 6, b"OggS", b"OggS Launch 5PM", b"We will figure out how to get the project to expand like $PEPE. Tele: https://t.me/Oggy_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/tCLar8U.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x6657381241f5aa003b5e1782c88b9c3d1ccfb3bf4c16536620bcc6f51456599d;
        0x2::coin::mint_and_transfer<OGGS>(&mut v2, 1000000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGS>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

