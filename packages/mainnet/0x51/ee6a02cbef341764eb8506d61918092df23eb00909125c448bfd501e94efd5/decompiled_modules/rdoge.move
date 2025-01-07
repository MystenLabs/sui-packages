module 0x51ee6a02cbef341764eb8506d61918092df23eb00909125c448bfd501e94efd5::rdoge {
    struct RDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RDOGE>(arg0, 6, b"RDoge", b"Reddit DOGE", b"RedditDoge is a dog with great vision and influence, he wants to create a global movement where everyone has the opportunity to manage their life and assets without being bound by the outdated banking system.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726207770279_3686efd09cee30fe9841be90899aff0d_344b7d4272.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

