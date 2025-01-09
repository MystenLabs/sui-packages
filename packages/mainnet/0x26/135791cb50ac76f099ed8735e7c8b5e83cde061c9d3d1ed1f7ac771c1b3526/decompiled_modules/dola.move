module 0x26135791cb50ac76f099ed8735e7c8b5e83cde061c9d3d1ed1f7ac771c1b3526::dola {
    struct DOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLA>(arg0, 6, b"DOLA", b"Dolphin agent", b"Dolphin Agent leverages the power of AI with a continuously updated training model and the inherent transparency of blockchain to develop a robust and democratic project framework. By democratizing the AI development process and lowering the barriers to entry found in traditional systems, Dolphin Agent ensures equal access for individuals, businesses, and communities to co-create the future of AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250110_031242_607_d3c6b05de4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

