module 0xcd15818f21d0367173b236e1dab454bb50f99c576174105e0ceb32a3d9711ae9::dgsga {
    struct DGSGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGSGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGSGA>(arg0, 6, b"DGSGA", b"JSHD", b"DHASGFDHGSAVDHGSAVDSAhjavdhGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4853_400_5db4a28911.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGSGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DGSGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

