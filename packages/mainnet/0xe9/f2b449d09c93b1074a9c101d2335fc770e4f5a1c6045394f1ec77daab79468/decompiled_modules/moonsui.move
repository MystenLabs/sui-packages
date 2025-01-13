module 0xe9f2b449d09c93b1074a9c101d2335fc770e4f5a1c6045394f1ec77daab79468::moonsui {
    struct MOONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONSUI>(arg0, 6, b"MOONSUI", b"Moon Sui", b"Were taking moon to $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5173_08f9746d04.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

