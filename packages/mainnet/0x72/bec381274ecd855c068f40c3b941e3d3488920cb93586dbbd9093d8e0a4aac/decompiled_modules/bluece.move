module 0x72bec381274ecd855c068f40c3b941e3d3488920cb93586dbbd9093d8e0a4aac::bluece {
    struct BLUECE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUECE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUECE>(arg0, 6, b"BLUECE", b"Blue Ice Can", b"The Blue Ice Can on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Ice_24_Cans_330m_L_a6aabb9ae0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUECE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUECE>>(v1);
    }

    // decompiled from Move bytecode v6
}

