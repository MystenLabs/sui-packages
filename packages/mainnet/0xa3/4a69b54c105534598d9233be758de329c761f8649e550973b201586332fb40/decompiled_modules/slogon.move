module 0xa34a69b54c105534598d9233be758de329c761f8649e550973b201586332fb40::slogon {
    struct SLOGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOGON>(arg0, 6, b"SLOGON", b"slogon", x"24534c4f474f4e206973206e6f74206865726520746f20637261776c2e20207c205468697320736c7567206973206275696c7420746f20636c696d622068696768657220616e64206e6576657220736c6f7720646f776e2e0a4c495645204f4e2053554921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gm_w_Ixx_Ww_AACOXX_1_58217e953e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

