module 0xaffe652267742b93c70bb3b653375ba73c048b92b31184351e25741bc27b2a0c::gcr {
    struct GCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCR>(arg0, 9, b"GCR", b"Galactic Credit", b"**Space Odyssey** is an ambitious multiplayer online strategy game designed to immerse players in a deep, interactive, and ever-changing space universe. Discover new worlds, build thriving colonies, and lead your fleet to victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/kGx5xQdc/IMG-20250720-181025.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GCR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCR>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

