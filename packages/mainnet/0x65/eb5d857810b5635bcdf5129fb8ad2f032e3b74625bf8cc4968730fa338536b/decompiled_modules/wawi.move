module 0x65eb5d857810b5635bcdf5129fb8ad2f032e3b74625bf8cc4968730fa338536b::wawi {
    struct WAWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWI>(arg0, 7, b"WAWI", b"WAWI", b"WAWI starts as a memecoin, but with a clear vision and a unique evolutionary strategy: to become a catalyst for positive change, equipped with real and concrete utilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://wawi.digital/wp-content/uploads/2025/01/wawi-logo-sui.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WAWI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWI>>(v2, @0xc5176cd9d44ecb77b9187d9fa7172789a9f5e31d1cb22b2e20ae55d6f14ce070);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

