module 0xf503f6fac70d25bd08704cd5e0b81a23bbc4b51bd745557db6be9323416be35::cliff {
    struct CLIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLIFF>(arg0, 6, b"Cliff", b"Dog Cliff", b"Coinbase Dog Cliff", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mmexport1728530174256_d93f4c4f32.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

