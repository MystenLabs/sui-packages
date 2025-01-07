module 0xe390aad12f14dfba308059cf1c7f5cfe0bf9255f0806a7b0b5d3282e7da7b566::time {
    struct TIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIME>(arg0, 6, b"TIME", b"it's my time", x"69742773206d792074696d6520746f206d616b652069740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmef_Nt_Jvupg1_T3_Nr5t_Rz_H_Ur_UHTF_5_Qm7_PRCVECA_Rc1_PQ_2uh_3bd7abcf17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

