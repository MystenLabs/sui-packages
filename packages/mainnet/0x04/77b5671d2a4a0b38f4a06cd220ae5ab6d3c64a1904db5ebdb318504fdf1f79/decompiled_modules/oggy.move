module 0x477b5671d2a4a0b38f4a06cd220ae5ab6d3c64a1904db5ebdb318504fdf1f79::oggy {
    struct OGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGY>(arg0, 9, b"OGGY", b"Sui Oggy", b"BEST OGGY ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://assets.zyrosite.com/cdn-cgi/image/format=auto,w=100,fit=crop,q=95/AoPvyGyNDph0050g/group-1-copy-3-YBgrM4R5pjFzlD02.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OGGY>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<OGGY>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGY>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

