module 0x60c74bacd81aa8b8f1795459c0072d38179035e361a92aff76c27452b46e145e::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"First PUGGO AI On Sui", b"First PUGGO AI On Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_152fc72def.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

