module 0x3d5f901e9d0c47adde0ab2ffadec12507832d5808746a9a2194e45feba1fdd1a::pxa {
    struct PXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PXA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PXA>(arg0, 6, b"PXA", b"Pixel Arena", b"PixelArena is a web open-source MMORPG, set in an infinite procedural voxel world. Forge your path to glory in a realm where your choices shape the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_0fbb10db29.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PXA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PXA>>(v1);
    }

    // decompiled from Move bytecode v6
}

