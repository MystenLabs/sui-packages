module 0x4cacaeb0093f6c86a605b5ffbd993961859e9be608368bb5877d3514cf9f5883::neiro {
    struct NEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRO>(arg0, 6, b"NEIRO", b"NEIRO ON SUI", b"$NEIRO. The new Shiba Inu dog, successor to the Doge dog after her passing.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F4_A1163_A_1493_4_E00_8_A42_ADA_41_AA_2_E07_B_97f57d13b0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

