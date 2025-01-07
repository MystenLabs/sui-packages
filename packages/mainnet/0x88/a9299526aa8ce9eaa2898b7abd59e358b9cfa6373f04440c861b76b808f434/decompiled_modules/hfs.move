module 0x88a9299526aa8ce9eaa2898b7abd59e358b9cfa6373f04440c861b76b808f434::hfs {
    struct HFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFS>(arg0, 6, b"HFS", b"HopFunSucks", b"Let's bond this and show we can moon faster than Hopfun can actually start working properly!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037228_aa7dfa8e10.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

