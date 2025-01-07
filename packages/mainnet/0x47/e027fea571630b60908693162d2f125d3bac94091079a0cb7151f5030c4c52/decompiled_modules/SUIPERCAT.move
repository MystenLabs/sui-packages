module 0x47e027fea571630b60908693162d2f125d3bac94091079a0cb7151f5030c4c52::SUIPERCAT {
    struct SUIPERCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERCAT>(arg0, 6, b"SUIPERCAT", b"SUIPERCAT", b"LFFFFGGGGGGG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/hoMnQ08.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIPERCAT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERCAT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

