module 0x4e306544e7f73b33e98d964a508297ae5694a330fc075e82d46d01ee021940ae::gorf {
    struct GORF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GORF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORF>(arg0, 6, b"GORF", b"gorf/frog", x"49276d206e6f7420646f696e6720616e797468696e6720626563757a2049276d20612074697265642066726f670a49206a7573742073656e642024474f524620746f206d696c6c696f6e73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_N4_L_Ec_Cu_400x400_d550e3c21f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GORF>>(v1);
    }

    // decompiled from Move bytecode v6
}

