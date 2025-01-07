module 0x3c524ee86d6a655dc199f50c5fc69af4d4eb75fae5901f5756b0436a31681c61::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"BLUBIA", b"Blubia", b"BLUBIA is BLUB's wife and she is the reigning QUEEN of the SUI OCEAN!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/copy11_69f73beb5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

