module 0xb0eee51eff1b06a909b9df33656d7ae0b5ecb4893958db451d0e8fd625120086::ruby {
    struct RUBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUBY>(arg0, 6, b"RUBY", b"Sui Ruby", b"Ruby - The most memeable memecoin to go beyond infinity ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000006995_afa9e68ce3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

