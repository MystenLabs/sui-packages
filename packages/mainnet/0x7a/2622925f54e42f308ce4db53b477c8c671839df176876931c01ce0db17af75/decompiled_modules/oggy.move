module 0x7a2622925f54e42f308ce4db53b477c8c671839df176876931c01ce0db17af75::oggy {
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

