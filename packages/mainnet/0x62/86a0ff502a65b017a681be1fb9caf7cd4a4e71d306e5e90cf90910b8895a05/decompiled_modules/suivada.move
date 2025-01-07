module 0x6286a0ff502a65b017a681be1fb9caf7cd4a4e71d306e5e90cf90910b8895a05::suivada {
    struct SUIVADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIVADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIVADA>(arg0, 6, b"SUIVADA", b"VADA of SUI", b"Feeding the hunger of a Billion people. Ready to onboard more from other countries just like how SUI is doing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vada_b97c3b9860.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIVADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIVADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

