module 0x2a026550198306263c7e8a88cc863851dce3e26f88a2c2c29a0095e3ce5543d7::long {
    struct LONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LONG>(arg0, 6, b"Long", b"naylong in sui", b"just buy and go to sleep", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dino_yellow_9423041dee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

