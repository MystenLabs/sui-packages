module 0xf9c19d5f01789543987125b6cb569b50cbad9835dd34480bc8c9c9a011024e2f::test420 {
    struct TEST420 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST420, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST420>(arg0, 6, b"TEST420", b"test", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST420>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TEST420>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

