module 0xb5d5fa9fd28ecf64a8743b040215416dabdc85ab3d9c4009d6b4f05c46674b7c::suidra {
    struct SUIDRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDRA>(arg0, 6, b"SUIDRA", b"Suidra the Hydra", b"Suidra, the ancient monster has awakened.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suidra_f11cf3542d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

