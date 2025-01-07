module 0x78e3b4f5f9efbe8150fc8e3c635cd8f2be8c87e9dfca58682d84b0b2fa6d7846::pagoda {
    struct PAGODA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAGODA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAGODA>(arg0, 6, b"PAGODA", b"Agoda", b"STONE is STOIC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_164056_6f0376a746.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAGODA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAGODA>>(v1);
    }

    // decompiled from Move bytecode v6
}

