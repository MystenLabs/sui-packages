module 0x776ac836d6b1ae66cef1639a9ddf554477452a5ccaac003ca30c5b750e3bc49f::dasf {
    struct DASF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DASF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DASF>(arg0, 6, b"DASF", b"fdvs", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DASF>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DASF>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

