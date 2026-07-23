module 0x3c6bc0ec62bd40b91feb3efd098f3e24794f782695bdc580ce164a8175847dbc::FDUSD {
    struct FDUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FDUSD>(arg0, 9, b"FDUSD", b"FDUSD", b"FDUSD Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.postimg.cc/v86GydmN/FDUSD.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FDUSD>>(0x2::coin::mint<FDUSD>(&mut v2, 210000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FDUSD>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDUSD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

