module 0x1b9b171134f95b754c7302bcf55835690249264f1b08a707a83b4db5b4aec6b3::daddy {
    struct DADDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADDY>(arg0, 6, b"DADDY", b"DADDY COIN ON SUI", x"547769747465723a2068747470733a2f2f782e636f6d2f6461646479636f696e6f6e7375690a54656c653a2068747470733a2f2f742e6d652f6461646479636f696e6f6e737569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_06_11_20_16_21_9d953e1736.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

