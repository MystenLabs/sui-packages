module 0x31b9e1d64323f6207af27b20167ad77206f4fe88a9c3c567106e85b6b0278be4::tai {
    struct TAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAI>(arg0, 6, b"TAI", b"TAI LUNG", b"Tai lung is the dragon warrior", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t_AI_LUNG_2d223e5bdb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

