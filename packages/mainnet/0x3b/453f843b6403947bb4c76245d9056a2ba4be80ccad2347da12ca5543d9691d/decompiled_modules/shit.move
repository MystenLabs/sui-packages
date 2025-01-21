module 0x3b453f843b6403947bb4c76245d9056a2ba4be80ccad2347da12ca5543d9691d::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHIT>(arg0, 6, b"SHIT", b"BullShitAI by SuiAI", b"Welcome to 2025, where AI is everywhere, but not everything it does is smart. Enter $bullshit, the sui-based meme token poking fun at how hilariously off-the-mark AI systems can still be.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2157_ad6ff987ab_8d14683fdd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

