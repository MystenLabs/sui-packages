module 0xc1149caf6ca431ee36b05938b4b245b9ede02bbcf4dd7deac2799dcd720d7f0d::grogoss {
    struct GROGOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGOSS>(arg0, 6, b"Grogoss", b"Groggo Sui", b"Groggo To The Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9315_d6045ac767.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGOSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGOSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

