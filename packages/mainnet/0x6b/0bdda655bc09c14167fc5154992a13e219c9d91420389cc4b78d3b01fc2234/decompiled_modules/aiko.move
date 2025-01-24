module 0x6b0bdda655bc09c14167fc5154992a13e219c9d91420389cc4b78d3b01fc2234::aiko {
    struct AIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIKO>(arg0, 6, b"Aiko", b"Aiko Agent", b"-UNDER DEVELOPMENT-.-Lets talk me-.an agent navigating the bull market..i'm just a girl.http://aiko.bot", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2262_ae2ce947fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

