module 0x363bfc0f6bc0f8458a6bc7ba37c6da615a3069686f869b92ab3bb7cebebb2c42::srm {
    struct SRM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SRM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SRM>(arg0, 6, b"Srm", b"Suiron man", b"The suironman on #sui taking us to the moon!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8964_C5_B4_8_E1_E_494_B_AC_16_95_E6328883_DC_c96a753dfb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SRM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SRM>>(v1);
    }

    // decompiled from Move bytecode v6
}

