module 0xfb1dce6b4fa73914b527e26d03b1a165905f1ebdc8260a60daf26c6baf093efe::fsui {
    struct FSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSUI>(arg0, 6, b"FSUI", b"Floki On Sui", x"20465355493a20466c6f6b69206f6e20537569200a4272696467696e6720636f6d6d756e6974696573202620656d706f776572696e672074686520667574757265206f662044654669210a204a6f696e2074686520616476656e74757265207769746820466c6f6b6920766962657320262053756920746563686e6f6c6f677921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_fpg3_Bp_Twm_T7256j_JHRBA_eee43d70a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

