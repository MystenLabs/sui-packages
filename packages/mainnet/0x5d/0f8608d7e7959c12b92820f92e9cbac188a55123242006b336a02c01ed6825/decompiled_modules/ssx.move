module 0x5d0f8608d7e7959c12b92820f92e9cbac188a55123242006b336a02c01ed6825::ssx {
    struct SSX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSX>(arg0, 6, b"SSX", b"Sui Sphynx (Binx)", b"CZ has now finally been reunited with his beloved Binx! She is a rare breed known as a Dwelf Sphynx Hairless. Her blue skin makes her the purrrrfect mascot for Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014870_07c4c9df5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSX>>(v1);
    }

    // decompiled from Move bytecode v6
}

