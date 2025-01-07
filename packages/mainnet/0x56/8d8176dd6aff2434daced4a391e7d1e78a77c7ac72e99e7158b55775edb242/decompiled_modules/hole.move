module 0x568d8176dd6aff2434daced4a391e7d1e78a77c7ac72e99e7158b55775edb242::hole {
    struct HOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLE>(arg0, 6, b"HOLE", b"BlackHole", b"Black Hole, the meme coin that defies the laws of crypto physics! It doesn't do anything, but it exists in the void, pulling your attention into its gravitational charm, forever expanding, never contracting. Hold it, laugh at it, forget about it; Black Hole is here for the ride, thriving in the cosmos of shitcoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hole_f4eb1f6e65.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

