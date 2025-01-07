module 0x9f642d4d4c85cc5dd8831cc5d0c422419192cf9501e5d9f9d28840f6c2c3a630::largedogs {
    struct LARGEDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LARGEDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LARGEDOGS>(arg0, 6, b"LARGEDOGS", b"Large Dog", b"They are a long dog but with money", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Omj_O_Vh_D7_400x400_804bb01427.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LARGEDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LARGEDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

