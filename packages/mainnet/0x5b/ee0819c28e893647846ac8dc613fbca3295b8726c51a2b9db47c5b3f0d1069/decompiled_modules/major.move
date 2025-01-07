module 0x5bee0819c28e893647846ac8dc613fbca3295b8726c51a2b9db47c5b3f0d1069::major {
    struct MAJOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAJOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAJOR>(arg0, 6, b"MAJOR", b"Major Frog", x"697374616b65732077657265206d61646520536570742e20362c2032303133207c2031313a323720706d204553540a0a412063616d65726120636170747572656420616e20696e7472696775696e672070686f746f206f6620612066726f67206173204e41534173204c414445452073706163656372616674206c69667473206f66662061742057616c6c6f707320466c6967687420466163696c6974790a0a576173207468697320616e206163636964656e743f20244d414a4f52206b6e6f7773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_Jts_DP_Rgz5_Envm_Eq_1_a8625f6ae9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAJOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAJOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

