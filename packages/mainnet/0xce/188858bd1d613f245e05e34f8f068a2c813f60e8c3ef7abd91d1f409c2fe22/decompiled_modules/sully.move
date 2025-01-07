module 0xce188858bd1d613f245e05e34f8f068a2c813f60e8c3ef7abd91d1f409c2fe22::sully {
    struct SULLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SULLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SULLY>(arg0, 6, b"SULLY", b"SUISULLY", b"Sully, the beloved monster, Well now hes retired thanks to his crypto portfolio.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nzm7_A0_UU_400x400_3f81dd1bf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SULLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SULLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

