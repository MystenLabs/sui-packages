module 0xd9955b1582933e5d059698f7cd33850f6cde9f47e25a2f2d358694f1a18b5060::diddysui {
    struct DIDDYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDYSUI>(arg0, 6, b"DiddySUI", b"MooDiddy", b"We're about to take over the memecoin scene, it's time for you guys to grab the big bags, or cry later.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2b3d5171_9666_4e9e_8212_caa27f1823d9_5f9ca5cb92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

