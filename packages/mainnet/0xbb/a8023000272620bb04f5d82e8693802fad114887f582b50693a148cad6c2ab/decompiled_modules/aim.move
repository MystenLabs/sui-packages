module 0xbba8023000272620bb04f5d82e8693802fad114887f582b50693a148cad6c2ab::aim {
    struct AIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIM>(arg0, 6, b"AIM", b"AIROOM", b"AI Room leverages the power of artificial intelligence to ensure top-notch security for every transaction.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_21_23_05_41_0249f34bf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

