module 0xd518ece229827e150dff22a4b8423e8f3a4b28b1c0d45ad5d4979299827c6e92::suinday {
    struct SUINDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINDAY>(arg0, 6, b"SUINDAY", b"SUINDAY ON SUI", b"Coming soon. Join the telegram!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_A5_ACC_8_B_B7_B3_432_D_B161_5_EB_2_E15424_FA_64a03e6d05.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

