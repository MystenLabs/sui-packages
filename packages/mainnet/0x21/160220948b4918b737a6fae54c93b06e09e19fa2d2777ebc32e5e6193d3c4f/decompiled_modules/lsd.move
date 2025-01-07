module 0x21160220948b4918b737a6fae54c93b06e09e19fa2d2777ebc32e5e6193d3c4f::lsd {
    struct LSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: LSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LSD>(arg0, 6, b"LSD", b"Let Sui Drive", b"We are high on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CEB_686_B6_A127_488_F_B97_B_863221960874_22aa47eddf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

