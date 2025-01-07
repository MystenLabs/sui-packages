module 0xb3b0f49d6f9e3a73fde6d9362e61412ba04e0f364f2c1eeee14f2959f7473f21::snomas {
    struct SNOMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOMAS>(arg0, 6, b"SNOMAS", b"SNOWY ON SUI", b"Im Snowy The Christmas Dog XD $SNOMAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0433_4dc7cc60b8.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNOMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

