module 0x5b2099833654ce4cfbc5ba1bb04f3ba05fff90aab19cada02159a4f50c0a94f9::ply {
    struct PLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLY>(arg0, 6, b"PLY", b"Polpy", b"Once upon a time, there was an octopus named Polpy, who lived in the depths of the ocean, far from the normal ocean currents. Polpy wasnt an ordinary octopus; he was the richest and most influential octopus in the entire marine kingdom. He had discovered a cave full of sunken treasuresgolden chests, sparkling pearls, and ancient jewels hidden by sunken ships. But the secret of his true wealth wasnt in material treasures: Polpy had the gift of turning anything he touched with his tentacles into riches.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8280_77485e498f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

