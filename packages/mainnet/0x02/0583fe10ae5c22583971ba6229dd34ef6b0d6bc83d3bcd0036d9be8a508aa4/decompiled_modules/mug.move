module 0x20583fe10ae5c22583971ba6229dd34ef6b0d6bc83d3bcd0036d9be8a508aa4::mug {
    struct MUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUG>(arg0, 6, b"MUG", b"MugCoinSui", b"Welcome to MUG - Memes Under Grou", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_142854_77726280c2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

