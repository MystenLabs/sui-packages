module 0xe4816490145bed90310408bfe81830adebe86ac8e1a6049d9b842a351ab05379::goofle {
    struct GOOFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOFLE>(arg0, 6, b"Goofle", b"Goofle AI", b"Turning giggles into gains.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241124_101643_157_6773388ca3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

