module 0x23c360063d8a2ae87046fd465579a597043d66d6932c21c9d247e8c8fe053e92::ichi {
    struct ICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ICHI>(arg0, 6, b"ICHI", b"Sui Ichi", b"ICHI-  is a Star Atlas Community Meme coin powered by the people for the people", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/90a20f_3c26d66b8e3545a7be02852111573f9c_mv2_57734e9b24.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ICHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

