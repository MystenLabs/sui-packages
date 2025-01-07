module 0x86f6e6530480112b2de48a3d0edafd84f3b811da5f70492758192c0f91546e71::gurmi {
    struct GURMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GURMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GURMI>(arg0, 6, b"Gurmi", b"SUi Gurmi", x"574520415245204e4f54204c4956452059455421204c41554e4348494e47204c4154455220544f444159212057452057494c4c20414e4e4f554e434520494e205447204120464557204d494e55544553204245464f5245204c41554e43482e200a0a444f204e4f542042555920414e5920544f4b454e205448415420444f4553204e4f542048415645204c495645205745425349544521205245414c204f4e452057494c4c20484156452057454253495445204c495645", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Main_Gurmi_Move_1_eb6109c031.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GURMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GURMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

