module 0xc2468dc4379a8b063c2288a5c8687de179219ad1f5ee0728c3375a4d05060279::cj {
    struct CJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CJ>(arg0, 6, b"CJ", b"Carl Johnson", b" CJ, the ultimate Grove Street OG! Invading SUI hood.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_e10e635947.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

