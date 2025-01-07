module 0x9b235a77f41602b6c50ba15a9f9bbf18e830e79643c4865589fadc5771e6ec1d::fuki {
    struct FUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKI>(arg0, 6, b"Fuki", b"Fuki Gang", b"Cold vibes on #SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/M9_ZZP_8_C6_400x400_4e83dbba25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

