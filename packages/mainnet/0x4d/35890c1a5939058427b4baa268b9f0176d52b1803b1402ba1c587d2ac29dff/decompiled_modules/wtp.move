module 0x4d35890c1a5939058427b4baa268b9f0176d52b1803b1402ba1c587d2ac29dff::wtp {
    struct WTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTP>(arg0, 6, b"WTP", b"White paper", b"It's a blank white paper. All crypto have a white paper. Don't buy it. No TG, no website, no Twitter! Just for fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2896_bfea078e82.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTP>>(v1);
    }

    // decompiled from Move bytecode v6
}

