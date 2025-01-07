module 0xa9a1443b44e3cd71c92c15ff15ef04484e9d2c266424c11634ab29dd4c1281df::fuu {
    struct FUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUU>(arg0, 6, b"FUU", b"FU", b"In a vibrant digital landscape where the realms of crypto and culture collide, Sui Fu emerges as a unique memecoin project, bringing to life the legendary story of a kung fu turtle.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_18_23_09_fbfd94186c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

