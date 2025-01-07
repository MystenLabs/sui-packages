module 0x3608c906e1a5fe3a48c99b04c23c15c3a0265fb2eab96efb75a80d612ff8805::meko {
    struct MEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEKO>(arg0, 6, b"MEKO", b"Meko V2", b"Meko is a leading memecoin on the Sui blockchain, with a primary focus on building a strong and solid community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241119_004825_f77645612f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

