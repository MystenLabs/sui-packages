module 0x476bacc7c6442d7a539480dc1fc463434af4484be2ec7c4ce8932a1d94938469::tnkl {
    struct TNKL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNKL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNKL>(arg0, 6, b"TNKL", b"TINKLE", x"54696e6b6c65202d2054686520536f756e64206f66205761746572206f6e205375692e20536f6f6e20746f206265202331204d656d65206f6e205375692e0a0a466f7267657420426c75622e204861766520612054696e6b6c652e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tinkle_3_96aef42a0b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNKL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNKL>>(v1);
    }

    // decompiled from Move bytecode v6
}

