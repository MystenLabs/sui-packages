module 0x36fdf5c62ff1defc586b78f7404fb46dc2f0fd7e96a7fa480a327dcb35d39348::psduck {
    struct PSDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSDUCK>(arg0, 6, b"PSDUCK", b"Psui Duck", b"P s u i D u c k ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000026537_f95f35e586.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSDUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

