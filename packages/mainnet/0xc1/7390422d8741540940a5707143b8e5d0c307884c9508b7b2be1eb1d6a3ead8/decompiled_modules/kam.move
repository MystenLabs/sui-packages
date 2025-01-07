module 0xc17390422d8741540940a5707143b8e5d0c307884c9508b7b2be1eb1d6a3ead8::kam {
    struct KAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAM>(arg0, 6, b"KAM", b"Kamala", b"dsfaljgdsak", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/star_ab0d6dab57.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

