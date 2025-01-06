module 0x469250b453dd7bdf81adf649ae0c281966486366e35ad3e0552e88fbe1f4b571::ox {
    struct OX has drop {
        dummy_field: bool,
    }

    fun init(arg0: OX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OX>(arg0, 6, b"OX", b"Oxomars by SuiAI", b"X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_4071_ae49c8229c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

