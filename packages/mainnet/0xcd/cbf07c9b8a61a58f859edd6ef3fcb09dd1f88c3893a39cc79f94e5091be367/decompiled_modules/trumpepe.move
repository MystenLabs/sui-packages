module 0xcdcbf07c9b8a61a58f859edd6ef3fcb09dd1f88c3893a39cc79f94e5091be367::trumpepe {
    struct TRUMPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPEPE>(arg0, 6, b"TRUMPEPE", b"CHILL TRUMPEPE GUY", b"TRUMPEPE leaned back in his tiny golden chair, sunglasses on, a meme-worthy smirk on his froggy face. \"They said it couldn't be done,\" he croaked. \"But here I am, the most memeable coin in history. Huge.\" As the blockchain confirmed another transaction, he whispered, \"Believe me, the chill is real.\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/112211_f14318f60a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

