module 0x1d86068685fe59cda26693e4917ea8e73ab246785a0b81756376d8d881990b72::one {
    struct ONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONE>(arg0, 6, b"ONE", b"One", b"A coin with one unit of supply. In a world where every meme coin unit of account has it's zeros on the right side of the decimal, choose a memecoin that puts it's zeros on the left side", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_30_at_10_46_56a_AM_83c6abc61b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

