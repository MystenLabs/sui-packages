module 0x53b27d294f0f4858803dc07d270ed690c00a9fe500ad040a05ee9456edf1c5d9::gal {
    struct GAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAL>(arg0, 6, b"GAL", b"Galileo Origins", b"Explore the power of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/IMG_8508_9244be09c5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

