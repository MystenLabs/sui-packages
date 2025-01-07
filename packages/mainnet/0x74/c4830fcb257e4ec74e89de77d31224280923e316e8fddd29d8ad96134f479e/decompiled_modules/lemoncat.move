module 0x74c4830fcb257e4ec74e89de77d31224280923e316e8fddd29d8ad96134f479e::lemoncat {
    struct LEMONCAT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LEMONCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LEMONCAT>>(0x2::coin::mint<LEMONCAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LEMONCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMONCAT>(arg0, 6, b"Sui Lemon Cat", b"sLemonCat", b"Sui Lemon Cat Meme Coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEMONCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEMONCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

