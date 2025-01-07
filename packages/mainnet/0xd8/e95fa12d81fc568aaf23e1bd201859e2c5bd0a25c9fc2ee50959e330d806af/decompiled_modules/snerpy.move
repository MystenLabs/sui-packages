module 0xd8e95fa12d81fc568aaf23e1bd201859e2c5bd0a25c9fc2ee50959e330d806af::snerpy {
    struct SNERPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNERPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNERPY>(arg0, 6, b"SNERPY", b"Snerpy on Sui", b"Snerpy derpy alter ego, full of meme spirit chill vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001654_c5c6646731.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNERPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNERPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

