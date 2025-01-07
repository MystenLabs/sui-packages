module 0x89c0658bac572630c37c3a85ac56ec1c2f5a7d8bf85806ce040e2534aa1f6199::movepump {
    struct MOVEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEPUMP>(arg0, 6, b"MOVEPUMP", b"MovePump", b"The Second Move Pump Meme on SUI Network by BlueMove Team", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/movepump_6085671fa4_1_3deb571eae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

