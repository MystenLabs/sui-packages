module 0x183f263478cff69e8355af00b83aab725e84d8efe78d768e27d34de2916b2a69::wuie {
    struct WUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUIE>(arg0, 6, b"WUIE", b"SUI WUIE", b"Wuie so happy on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/profile_4056464c67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

