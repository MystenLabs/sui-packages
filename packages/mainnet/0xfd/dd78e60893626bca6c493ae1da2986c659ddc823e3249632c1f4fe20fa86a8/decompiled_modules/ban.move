module 0xfddd78e60893626bca6c493ae1da2986c659ddc823e3249632c1f4fe20fa86a8::ban {
    struct BAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAN>(arg0, 6, b"BAN", b"ban", b"$Banana - About Banana: is a fun and quirky MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000349_81e680ba46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

