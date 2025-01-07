module 0x91ebeecf6c19fb217d9ff8c4a8c70f7856de5f6b17532680989a82c0d342afba::eee {
    struct EEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEE>(arg0, 6, b"EEE", b"eee dolphin", b"eeeeEEeeEeeeeEEEEeeeeEEEeeEEEEEEeeeeEEEeee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/10590196_9_C44_4_B2_F_8_FE_0_AD_023_E917538_792939cf5e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

