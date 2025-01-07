module 0x6a61b0edd7ae8c477ddc91633e54df47087313b190458d3a06a22a8151b59be4::nekochannekochan {
    struct NEKOCHANNEKOCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKOCHANNEKOCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKOCHANNEKOCHAN>(arg0, 6, b"NekochanNekochan", b"Neko", b"Cat is the best Cat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the bestCat is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pub-efea87dea3f94e8084e073588c980c50.r2.dev/logo/01JBGQ43S2XNAHPDZZH1CVCGJE/01JBGQ9MW64HR55ES04P920RY7")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKOCHANNEKOCHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEKOCHANNEKOCHAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

