module 0x83871952025f7c09308d6482f0763958145631d69d27ea78f9f6af1f89ee47a4::esti {
    struct ESTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESTI>(arg0, 6, b"ESTI", b"Esti dog", b"funny dogs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c7846819_ea64_40e8_b5e9_4efc3846d14c_4de79626a4.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

