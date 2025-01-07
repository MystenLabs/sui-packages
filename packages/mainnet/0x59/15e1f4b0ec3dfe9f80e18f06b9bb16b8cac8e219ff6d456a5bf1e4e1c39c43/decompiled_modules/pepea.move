module 0x5915e1f4b0ec3dfe9f80e18f06b9bb16b8cac8e219ff6d456a5bf1e4e1c39c43::pepea {
    struct PEPEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEA>(arg0, 9, b"PEPEA", b"Aqua Pepe", b"Aqua Pepe is a vibrant token blending the playful charm of Pepe the Frog with the cool, refreshing vibe of aqua. It's perfect for meme lovers seeking a fun and unique digital asset in the crypto space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1674785358389866503/-8372A2r.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPEA>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

