module 0x5f2c1ee7cf54da3ac0d925c1e858c89f0c3d4bae91c5a6f9c7c89d341f906b34::bsag {
    struct BSAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSAG>(arg0, 6, b"BSAG", b"BOB THE SUI HOLDER", x"426f62205468652053756920486f6c6465722077696c6c206e657665722067657420726964206f662068697320626167732c2064657374696e656420746f206361727279207468656d20666f72657665722e2049742073746172746564207769746820464f4d4f207468656e20484f444c2073657420696e2c20736f6f6e20746865726520776f6e27742062652061206261672062696720656e6f7567682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/j_X_Ltn_bx_400x400_b49096d220.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

