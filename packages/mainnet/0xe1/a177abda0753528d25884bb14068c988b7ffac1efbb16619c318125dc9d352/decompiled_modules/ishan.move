module 0xe1a177abda0753528d25884bb14068c988b7ffac1efbb16619c318125dc9d352::ishan {
    struct ISHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISHAN>(arg0, 6, b"ISHAN", b"Ishan Coin", b"Don't debate me, you'll lose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_removebg_preview_2024_10_30_T133725_538_3635024faa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISHAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

