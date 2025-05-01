module 0xa1e1638ed68f65e0d44189c9f48f7e725d7f20d38d1f7e8dc8d610b1aea3d910::scs {
    struct SCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCS>(arg0, 6, b"SCS", b"Sand coral Sui", b"If the ocean has deep and wide water, sand and diamonds will not be forgotten and sand the coral ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086644_20ea1ac29d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

