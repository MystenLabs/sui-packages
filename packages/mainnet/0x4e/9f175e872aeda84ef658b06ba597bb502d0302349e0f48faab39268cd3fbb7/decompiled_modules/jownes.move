module 0x4e9f175e872aeda84ef658b06ba597bb502d0302349e0f48faab39268cd3fbb7::jownes {
    struct JOWNES has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOWNES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOWNES>(arg0, 6, b"JOWNES", b"alux jownes", b"Fight the globalists, the ticker is $JOWNES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/vhw_Si_UMK_400x400_8a9318a96e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOWNES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOWNES>>(v1);
    }

    // decompiled from Move bytecode v6
}

