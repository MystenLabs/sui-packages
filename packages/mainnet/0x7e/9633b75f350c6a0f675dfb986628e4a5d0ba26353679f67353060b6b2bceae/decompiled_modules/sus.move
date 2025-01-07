module 0x7e9633b75f350c6a0f675dfb986628e4a5d0ba26353679f67353060b6b2bceae::sus {
    struct SUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUS>(arg0, 6, b"SUS", b"OCTOSUS", x"537573706963696f7573206279206e61747572652c204f63746f535553206973206865726520746f20696e6b20746865206d656d65636f696e2067616d652e200a406f63746f7375735355490a234f63746f535553202353746179535553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfp_e279a7d398.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

