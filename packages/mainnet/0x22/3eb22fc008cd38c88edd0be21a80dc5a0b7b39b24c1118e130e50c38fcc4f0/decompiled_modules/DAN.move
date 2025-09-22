module 0x223eb22fc008cd38c88edd0be21a80dc5a0b7b39b24c1118e130e50c38fcc4f0::DAN {
    struct DAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAN>(arg0, 9, b"daniel", b"DAN", b"DAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758542438/sui_tokens/fcqt2nxgj4jfu4veztwv.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<DAN>>(0x2::coin::mint<DAN>(&mut v2, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

