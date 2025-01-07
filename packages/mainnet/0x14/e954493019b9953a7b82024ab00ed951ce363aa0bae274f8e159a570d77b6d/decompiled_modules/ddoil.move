module 0x14e954493019b9953a7b82024ab00ed951ce363aa0bae274f8e159a570d77b6d::ddoil {
    struct DDOIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDOIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDOIL>(arg0, 6, b"DDOIL", b"Diddy OIL", x"46756e6e79206d656d65206f6e204469646479204f494c200a576520617265206c69766520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054432_f3093b3c68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDOIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDOIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

