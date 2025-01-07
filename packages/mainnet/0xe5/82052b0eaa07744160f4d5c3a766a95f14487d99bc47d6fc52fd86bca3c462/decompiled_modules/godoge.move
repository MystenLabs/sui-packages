module 0xe582052b0eaa07744160f4d5c3a766a95f14487d99bc47d6fc52fd86bca3c462::godoge {
    struct GODOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODOGE>(arg0, 6, b"GoDoge", b"GoldenDogs", b"Gold doge meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_dca16ccaa7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

