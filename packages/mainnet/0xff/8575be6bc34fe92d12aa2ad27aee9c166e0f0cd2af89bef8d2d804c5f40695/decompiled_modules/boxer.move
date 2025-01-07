module 0xff8575be6bc34fe92d12aa2ad27aee9c166e0f0cd2af89bef8d2d804c5f40695::boxer {
    struct BOXER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXER>(arg0, 6, b"Boxer", b"SUIBoxer", b"SUI i want to apologize / LP locked & mint immutable/ txid: HfPUQqceqH3mLMGbLDMxEYfey7DophfAQ8ecsspifkZ8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/boxer_88ba3c9f92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXER>>(v1);
    }

    // decompiled from Move bytecode v6
}

