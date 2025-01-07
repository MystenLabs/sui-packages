module 0xfe3f827176833e280dd52d902704977e2b9f4a5462dcfa5f6bfb153feac6250b::sdino {
    struct SDINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDINO>(arg0, 6, b"SDINO", b"Suidino", b"Who has the banana here?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_dino_2efbdc05f4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

