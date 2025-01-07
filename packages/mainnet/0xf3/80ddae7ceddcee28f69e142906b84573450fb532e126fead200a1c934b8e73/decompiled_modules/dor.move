module 0xf380ddae7ceddcee28f69e142906b84573450fb532e126fead200a1c934b8e73::dor {
    struct DOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOR>(arg0, 6, b"DOR", b"Doraemon", b"Doraemon is coming to Sui! Mata ashita!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_5_477e7a1bec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

