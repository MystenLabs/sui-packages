module 0x51dd7c09ab0168f21df31cd1c61e1b99abf3e80df44f7962f07a0a5470786fb5::hoho {
    struct HOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHO>(arg0, 6, b"HOHO", b"HOHOHO Sui Santa", b"Bringing festive vibes to the Sui blockchain! With the Naughty and Nice List, holders can earn exclusive rewards for good behaviour.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoho_ca6540b0ea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

