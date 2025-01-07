module 0x7abb758c211e7bd74cb7c11afc24d250641431385d7104f814986e16b50e0758::flappy {
    struct FLAPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLAPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLAPPY>(arg0, 6, b"Flappy", b"Flappy Bird", x"506c617920666c6170707920626972642068657265206f6e6c696e6520666f7220667265652e200a446f6e277420627579206d656d6520466c617070790a68747470733a2f2f6c696e6b74722e65652f666c617070795f62697264", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/th_5bf4fe4b0b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLAPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLAPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

