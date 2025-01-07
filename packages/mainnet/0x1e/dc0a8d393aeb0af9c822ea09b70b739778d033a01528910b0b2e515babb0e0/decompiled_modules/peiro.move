module 0x1edc0a8d393aeb0af9c822ea09b70b739778d033a01528910b0b2e515babb0e0::peiro {
    struct PEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEIRO>(arg0, 6, b"PEIRO", b"PEPE NEIRO", b"PEIRO iS a community driven Tribute token to $PEPE & $NEIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_04_17_41_31_65b0bd3d08.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

