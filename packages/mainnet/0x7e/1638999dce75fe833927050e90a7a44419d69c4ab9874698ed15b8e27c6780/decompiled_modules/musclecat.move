module 0x7e1638999dce75fe833927050e90a7a44419d69c4ab9874698ed15b8e27c6780::musclecat {
    struct MUSCLECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUSCLECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUSCLECAT>(arg0, 6, b"MuscleCat", b"Muscle Cat", x"43617420736561736f6e206973206261636b2e205472756520737569204379636c65204d656d6520436174730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Muscle_Cat_TB_Pbuy_YNU_Dv_Ws_O7_Z4e_11d44d918b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUSCLECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUSCLECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

