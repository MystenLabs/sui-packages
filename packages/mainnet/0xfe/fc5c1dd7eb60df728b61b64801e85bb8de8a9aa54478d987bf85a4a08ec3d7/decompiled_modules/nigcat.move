module 0xfefc5c1dd7eb60df728b61b64801e85bb8de8a9aa54478d987bf85a4a08ec3d7::nigcat {
    struct NIGCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGCAT>(arg0, 6, b"NIGCAT", b"NiggaCatSui", b"Welcome to NiggaCatSui! We're thrilled to announce that we're going live in just a few minutes on MovePump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nigga_993b2b9ce8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIGCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

