module 0x1a2ad92e5256c331f665179eafbb1c6253c30e75c01397e4e1dfb3e7dd060eb::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHI>(arg0, 6, b"MOCHI", b"MOCHI ON SUI", b"We aimed for the moon...but someone wanted to ruin our community by dumping. We will be back up there!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gbtp_Kx_RWQ_Awi_P_p_0088501e57.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOCHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

