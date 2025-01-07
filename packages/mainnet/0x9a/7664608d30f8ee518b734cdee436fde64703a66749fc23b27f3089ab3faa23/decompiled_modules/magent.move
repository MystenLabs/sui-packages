module 0x9a7664608d30f8ee518b734cdee436fde64703a66749fc23b27f3089ab3faa23::magent {
    struct MAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGENT>(arg0, 6, b"Magent", b"The Magent", b"LOCK IN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/magnet_1f9f2_a4972b92c4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGENT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGENT>>(v1);
    }

    // decompiled from Move bytecode v6
}

