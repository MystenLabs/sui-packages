module 0x7e24de322b3999676afe9cc5d9c19e86b2e54f47e269235b7187dcb149415e54::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 9, b"OGGY", b"Sui Oggy", b"Oggy on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1843597243439558658/Ijj4JYFG_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

