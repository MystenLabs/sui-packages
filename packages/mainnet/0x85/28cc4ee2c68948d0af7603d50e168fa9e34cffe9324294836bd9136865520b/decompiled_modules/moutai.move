module 0x8528cc4ee2c68948d0af7603d50e168fa9e34cffe9324294836bd9136865520b::moutai {
    struct MOUTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOUTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOUTAI>(arg0, 6, b"MOUTAI", b"SUI MOUTAI", b"Moutai - The miracle of Chinese stocks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VU_7_P_9p_400x400_24fc57152c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOUTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOUTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

