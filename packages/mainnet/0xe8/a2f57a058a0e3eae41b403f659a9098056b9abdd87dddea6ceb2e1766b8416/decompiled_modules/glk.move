module 0xe8a2f57a058a0e3eae41b403f659a9098056b9abdd87dddea6ceb2e1766b8416::glk {
    struct GLK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLK>(arg0, 6, b"GLK", b"Galactic Krone", x"42792074686520636f6d6d616e64206f662047616c6163746963204b696e67204d6178696d696c6c69616e2074686520576973652c2074686520526f79616c204d696e742c20756e646572207468650a6c656164657273686970206f662043726f776e205072696e6365204c656f706f6c642c206f6e2032382e31322e323032342c206c6f63616c20706c616e65746172792074696d652c206973737565733a0a31302c3030302c3030302c30303020756e697473206f66207468652047616c6163746963204b726f6e652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dq_A_Sgdw_Fvd_LD_Va_Drg8_Umr9t_YA_Tmc_Pc_Fr_Gw_W3z_Rp_FJ_5t_503b3731f5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLK>>(v1);
    }

    // decompiled from Move bytecode v6
}

