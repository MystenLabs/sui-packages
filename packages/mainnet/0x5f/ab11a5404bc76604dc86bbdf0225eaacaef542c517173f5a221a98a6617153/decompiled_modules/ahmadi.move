module 0x5fab11a5404bc76604dc86bbdf0225eaacaef542c517173f5a221a98a6617153::ahmadi {
    struct AHMADI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHMADI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHMADI>(arg0, 6, b"AHMADI", b"Mahmoud Ahmadinejad", b"in memory of the great Mahmoud Ahmadinejad, the one and only president of Iran from 2005 to 2013.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ahmadi_2688050af8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHMADI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHMADI>>(v1);
    }

    // decompiled from Move bytecode v6
}

