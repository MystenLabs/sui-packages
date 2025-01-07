module 0xd2521e31fa114fbe24bcd37c3afc5b64665b9b245554563cd3c72cce51d51446::betta {
    struct BETTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BETTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BETTA>(arg0, 6, b"BETTA", b"BettaFish Sui", b"$BETTA the newest meme fish swimming on Sui water!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001685_4c8603d566.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BETTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BETTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

