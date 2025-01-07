module 0xff1ecac6ae552436be5def995d9292f9f06bf47711ab213892ccb34d99dd50f::koko {
    struct KOKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOKO>(arg0, 6, b"KOKO", b"KOKOS", b"KOKO ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_25_14_59_55_63a9b1c68c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

