module 0xc0b1a3121e1eee7ee1575cdb2bc9b94a063d9afc46a3942e3cc39e68b21dc4b7::sandog {
    struct SANDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANDOG>(arg0, 6, b"SANDOG", b"Santa Dog", b"Sandog - The first Santa dog on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000021581_e67cc0ac2e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

