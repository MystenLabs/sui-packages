module 0x6cc8bf33509f2e36e5637b3930373595c89ec6cf8a671310a29d77fa95e0f51a::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 9, b"OGGY", b"Sui Oggy", b"BEST OGGY ON SUI CHAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/QM4Fg8Xw/1.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGGY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

