module 0x7c87c5b49b839f67e5e52569e15fc6edaa9ce87ba5b50847b3be282449dc808f::aduck {
    struct ADUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADUCK>(arg0, 6, b"ADUCK", b"AAADUCK", b"This is a duck that wants to be filled, and I hope you can help it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_24_04_22_40_2211c56465.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

