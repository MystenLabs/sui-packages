module 0x111fcd2ff5fc54ae4ceb81af59a667bce830c64b1c9cbede623e337cecc2e42e::luga {
    struct LUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUGA>(arg0, 6, b"LUGA", b"LUGA Whale", b"hallo I'm a beluga whale. aqualuga.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_120821_973ea448f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

