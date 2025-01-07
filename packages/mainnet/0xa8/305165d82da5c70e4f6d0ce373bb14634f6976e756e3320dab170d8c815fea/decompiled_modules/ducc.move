module 0xa8305165d82da5c70e4f6d0ce373bb14634f6976e756e3320dab170d8c815fea::ducc {
    struct DUCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCC>(arg0, 6, b"DUCC", b"DUCConSUI", b"quack quack", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DUCC_f9efcfe805.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

