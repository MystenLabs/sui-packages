module 0xdb34c7132d3c5baafa5e59fd98c2af59a8ff961412347a020068f671256355d2::nar {
    struct NAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAR>(arg0, 6, b"NAR", b"Narwhal", b"An adorably oblivious narwhal who's always making waves in the deep sea, riding through chaos with a goofy grin!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4488_c435749f18_083388f8a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

