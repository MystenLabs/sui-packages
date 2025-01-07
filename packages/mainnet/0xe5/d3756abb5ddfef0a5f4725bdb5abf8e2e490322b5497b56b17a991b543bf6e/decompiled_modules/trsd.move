module 0xe5d3756abb5ddfef0a5f4725bdb5abf8e2e490322b5497b56b17a991b543bf6e::trsd {
    struct TRSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRSD>(arg0, 6, b"TRSD", b"Tremp Sui", b"Donald Trump on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9239_45266da5c0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

