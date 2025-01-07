module 0xae91f79247f1cb5af6930df169a63a8d04bdfbdf201fabcdb0babb8a24a996e4::pnutfart {
    struct PNUTFART has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNUTFART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNUTFART>(arg0, 6, b"PnutFart", b"Farting Pnut", x"5065616e75742077616e747320746f2073656520746865206d6f6f6e206f6e65206d6f72652074696d65206f6e2053756920736f2068652069732066617274696e67206869732077617920746865726520746f207369676e616c207468652072697365206f662068696d20676f696e6720746f20746865206d6f6f6e20616761696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_NZXB_3pa_PBJ_Nmq_S9pa_Lj_N_Xrc57_Ym_B8_SU_Xcwuq_Ynaw6_AXN_8006291547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNUTFART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PNUTFART>>(v1);
    }

    // decompiled from Move bytecode v6
}

