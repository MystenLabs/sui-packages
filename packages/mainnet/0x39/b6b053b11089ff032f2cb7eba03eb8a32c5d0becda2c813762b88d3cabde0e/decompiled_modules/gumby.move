module 0x39b6b053b11089ff032f2cb7eba03eb8a32c5d0becda2c813762b88d3cabde0e::gumby {
    struct GUMBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUMBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUMBY>(arg0, 6, b"GUMBY", b"Gumby on SUI", b"Gumby, the beloved blue clay character, is known for his quirky charm and endless flexibility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_20_17_20_17_1670722c61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUMBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUMBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

