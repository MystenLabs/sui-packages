module 0x6015bd8a50d75e0079041c80fcd8efb3fc54b833874da4b4cde7688518ba0f1f::bpochita {
    struct BPOCHITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPOCHITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPOCHITA>(arg0, 6, b"bPOCHITA", b"BabyPochita", b"Baby Pochita", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Kakao_Talk_20241003_033203593_0da9e1393c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPOCHITA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPOCHITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

