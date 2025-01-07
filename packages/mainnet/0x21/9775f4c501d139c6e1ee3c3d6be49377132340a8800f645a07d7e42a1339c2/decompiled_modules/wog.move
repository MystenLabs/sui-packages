module 0x219775f4c501d139c6e1ee3c3d6be49377132340a8800f645a07d7e42a1339c2::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 6, b"WOG", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://api.movepump.com/uploads/photo_2024_11_20_22_02_01_4be3bb07da.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOG>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOG>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WOG>>(v2);
    }

    // decompiled from Move bytecode v6
}

