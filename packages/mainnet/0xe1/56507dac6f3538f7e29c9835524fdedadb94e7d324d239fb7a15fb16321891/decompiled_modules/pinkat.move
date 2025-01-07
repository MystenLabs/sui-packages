module 0xe156507dac6f3538f7e29c9835524fdedadb94e7d324d239fb7a15fb16321891::pinkat {
    struct PINKAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKAT>(arg0, 6, b"PINKAT", b"Pinkat sui", b"$PinKat never sleep. PinKat always learn. PinKat is life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053040_7bd2877654.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PINKAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PINKAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

