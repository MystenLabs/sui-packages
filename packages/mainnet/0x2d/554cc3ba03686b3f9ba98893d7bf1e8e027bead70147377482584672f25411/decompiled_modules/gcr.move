module 0x2d554cc3ba03686b3f9ba98893d7bf1e8e027bead70147377482584672f25411::gcr {
    struct GCR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCR>(arg0, 6, b"GCR", b"Galactic Credit", b"**Space Odyssey** is an ambitious multiplayer online strategy game designed to immerse players in a deep, interactive, and ever-changing space universe. Discover new worlds, build thriving colonies, and lead your fleet to victory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000029360_eb3eb0662e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GCR>>(v1);
    }

    // decompiled from Move bytecode v6
}

