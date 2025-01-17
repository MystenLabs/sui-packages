module 0x4e138feb8cdcb66aa1ea565463dfbc8646f0b9a4f165533eee56d01dca34f39c::mai {
    struct MAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAI>(arg0, 6, b"MAI", b"Metaverse AI", b"A dynamic metaverse showcasing multiple crypto projects, each represented by unique holographic logos and themed districts. The environment features diverse virtual spaces interconnected by glowing data pathways, with floating platforms for trading, NFT galleries, decentralized hubs, and immersive project showcases. Neon-lit visuals emphasize collaboration and innovation in a unified digital ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2025_01_17_10_20_50_A_futuristic_depiction_of_an_AI_driven_metaverse_The_scene_showcases_a_bustling_virtual_city_filled_with_holographic_advertisements_diverse_avatars_8a43cd73d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

