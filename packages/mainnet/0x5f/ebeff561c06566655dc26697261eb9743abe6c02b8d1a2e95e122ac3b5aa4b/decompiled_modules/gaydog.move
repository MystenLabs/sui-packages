module 0x5febeff561c06566655dc26697261eb9743abe6c02b8d1a2e95e122ac3b5aa4b::gaydog {
    struct GAYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYDOG>(arg0, 6, b"GAYdog", b"GAY DOG", b"hello im gay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_fbf18eaa6a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

