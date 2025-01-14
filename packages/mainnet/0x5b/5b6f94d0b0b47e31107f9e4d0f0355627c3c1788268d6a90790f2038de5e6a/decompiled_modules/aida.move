module 0x5b5b6f94d0b0b47e31107f9e4d0f0355627c3c1788268d6a90790f2038de5e6a::aida {
    struct AIDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIDA>(arg0, 9, b"AIDA", b"Aida", b"Aida is a dynamic and user-friendly Al bot designed to guide X users into the world of the Sui Network. With her approachable personality and deep understanding of blockchain nuances, Lucy makes the transition from Social media to blockchain technology both exciting and accessible.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_12_19_22_11_19_1dbcb256da.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIDA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<AIDA>>(0x2::coin::mint<AIDA>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AIDA>>(v2);
    }

    // decompiled from Move bytecode v6
}

