module 0xe5cd3ffe385e0cb76369e28d6fc2fa78d6fb8756af000158d0d4d30f66332299::psycho {
    struct PSYCHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSYCHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSYCHO>(arg0, 6, b"PSYCHO", b"Patrick Bateman", b"I am Patrick Bateman the best SIGMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/American_psycho_patrick_bateman_d9c9b3dc38.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSYCHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSYCHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

