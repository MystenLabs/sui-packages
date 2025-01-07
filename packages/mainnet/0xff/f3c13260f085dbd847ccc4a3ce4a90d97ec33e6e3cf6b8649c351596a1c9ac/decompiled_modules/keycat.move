module 0xfff3c13260f085dbd847ccc4a3ce4a90d97ec33e6e3cf6b8649c351596a1c9ac::keycat {
    struct KEYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEYCAT>(arg0, 6, b"KEYCAT", b"Keyboard Cat", b"Keyboard Cat is an iconic internet meme featuring a cat named Fatso, who plays a keyboard with surprising musical talent! Since Fatso's debut in 2007, two other cats, Bento and Skinny, have carried on the legacy, keeping the internet entertained with their paws-on performances. Together, these three feline virtuosos have become a symbol of meme culture, inspiring laughter and countless parodies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x9a26f5433671751c3276a065f57e5a02d2817973_3eab752c87.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

