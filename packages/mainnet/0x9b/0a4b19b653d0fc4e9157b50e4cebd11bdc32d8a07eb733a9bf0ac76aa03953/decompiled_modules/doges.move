module 0x9b0a4b19b653d0fc4e9157b50e4cebd11bdc32d8a07eb733a9bf0ac76aa03953::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 6, b"DogeS", b"DogeSui", b"First sui doge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/eb11a58b894e64f7f86282e145af581c_9a88982528.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGES>>(v1);
    }

    // decompiled from Move bytecode v6
}

