module 0x9265f01bee16c923a0c326a30b7c9c9023a4d33118e19ab48035ee01313f792f::bolt {
    struct BOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOLT>(arg0, 6, b"BOLT", b"Bolt on Sui", b"Top Dog Bot On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hero_image_1_f40a56d6c2.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

