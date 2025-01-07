module 0xd5080f667a2e4bc94695ada8a2423fca8a9ad4f7a83e157fbeb83b8bcd7b66aa::wubba {
    struct WUBBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUBBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUBBA>(arg0, 6, b"Wubba", b"suiwubba", b"SuiWubba is the ultimate meme coin on the Sui blockchain, inspired by the iconic \"Wubba Lubba Dub Dub!\" catchphrase from Rick and Morty. Just like Rick Sanchez travels through dimensions, SuiWubba is ready to take you on a wild ride through the world of crypto. Fueled by community, fun, and the power of memes, SuiWubba is designed for those who want to get schwifty while chasing moonshots.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/happybirthday_1_3ae60441bc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUBBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUBBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

