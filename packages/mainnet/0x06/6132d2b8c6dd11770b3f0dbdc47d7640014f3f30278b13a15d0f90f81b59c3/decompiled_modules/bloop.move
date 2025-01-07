module 0x66132d2b8c6dd11770b3f0dbdc47d7640014f3f30278b13a15d0f90f81b59c3::bloop {
    struct BLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOP>(arg0, 6, b"BLOOP", b"Bloop The Bluga", b"Bloop the Beluga is a playful, ocean-inspired journey into the world of crypto gaming, built on the Sui chain. Dive into a vibrant, interactive world where popular Sui projects come to life through Augmented Reality (AR). As players, youll experience exciting collaborations, with each project revealing unique AR and HTML games that are easy to access and rewarding to play. By merging creativity and technology, Bloop the Beluga not only offers a thrilling play-to-earn experience but also bridges the gap between virtual worlds and reality, bringing innovation to the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048778_c324d3459e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

