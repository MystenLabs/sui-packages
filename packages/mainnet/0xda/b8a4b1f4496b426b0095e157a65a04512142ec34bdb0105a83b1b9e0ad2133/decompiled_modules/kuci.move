module 0xdab8a4b1f4496b426b0095e157a65a04512142ec34bdb0105a83b1b9e0ad2133::kuci {
    struct KUCI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUCI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUCI>(arg0, 6, b"KUCI", b"KUCING ON SUI", b"A graceful white cat with fur as soft as snow strolls along the beach, its tiny paw prints left in the damp sand. Its clear blue eyes reflect the shimmering ocean waves under the golden glow of the sunset. Its long tail sways gently, in harmony with the sea breeze sweeping across the shore.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_8fd08ff7a0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUCI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUCI>>(v1);
    }

    // decompiled from Move bytecode v6
}

