module 0x447bc7bcf9897c05cecea2312170fe91a8d9bea22d7f3231a86526a321011c46::italiana {
    struct ITALIANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITALIANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITALIANA>(arg0, 6, b"ITALIANA", b"ITALIAN GIRL", b"A italian girl for all sui wallet ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image1_0_1_1b1752e435.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITALIANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITALIANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

