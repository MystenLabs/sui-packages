module 0x1f247ab755b9539eff62c4f2a291c9d8ec5cfd54fa4ef17b99d425de4179fcbf::rbs {
    struct RBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RBS>(arg0, 6, b"RBS", b"Rabbit SUI", b"Rabbit SUI is quickly becoming the next big name on the Sui network, driving innovation with lightning speed. Backed by a passionate community and built on solid foundations, Rabbit SUI is more than just a trendit's a movement. As the project gains momentum, early supporters are already seeing the benefits. Dont get left behind while others ride the wave of success. The time to act is now, before this opportunity hops out of reach!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1140_77ac62717b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RBS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RBS>>(v1);
    }

    // decompiled from Move bytecode v6
}

