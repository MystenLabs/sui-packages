module 0x72b963287fb467aa8bef1a2c8dd3bbf617cb57c028156dfddb7028113b3bc875::moot {
    struct MOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOOT>(arg0, 6, b"MOOT", b"Moot Manga", b"Meme coin? Nah, we're marine-grade manga machine.  Dropping comic so spicy, even your wallet blushed. $MOOT - Come for the chaos, stay for the story", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076388_c4c063d190.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

