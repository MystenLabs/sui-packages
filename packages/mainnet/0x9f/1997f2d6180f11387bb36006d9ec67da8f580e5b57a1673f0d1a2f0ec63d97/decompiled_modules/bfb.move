module 0x9f1997f2d6180f11387bb36006d9ec67da8f580e5b57a1673f0d1a2f0ec63d97::bfb {
    struct BFB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFB>(arg0, 6, b"BFB", b"Big Foot Billy", x"446f6e27742062652073696c6c792c20697427732042696720466f6f742042696c6c792e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000030382_e3c2e89eb8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFB>>(v1);
    }

    // decompiled from Move bytecode v6
}

