module 0x547ed20be47034db6773034ab368ae5d48aaada83bd353f92ab1549b740af355::sswn {
    struct SSWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSWN>(arg0, 6, b"SSWN", b"SPEEDY SWAN", b"Elegant and swift, Speedy Swan glides effortlessly to meme success.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_043337379_e641e4e75e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

