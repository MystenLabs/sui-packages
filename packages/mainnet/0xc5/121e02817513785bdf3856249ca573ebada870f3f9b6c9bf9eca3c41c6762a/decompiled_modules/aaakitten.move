module 0xc5121e02817513785bdf3856249ca573ebada870f3f9b6c9bf9eca3c41c6762a::aaakitten {
    struct AAAKITTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAKITTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAKITTEN>(arg0, 6, b"AAAKITTEN", b"AaaKitten", b"Can't stop won't stop (Loving Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Aaa_Cat_64a015adf5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAKITTEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAKITTEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

