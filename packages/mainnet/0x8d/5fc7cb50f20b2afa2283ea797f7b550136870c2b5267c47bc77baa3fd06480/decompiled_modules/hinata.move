module 0x8d5fc7cb50f20b2afa2283ea797f7b550136870c2b5267c47bc77baa3fd06480::hinata {
    struct HINATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HINATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HINATA>(arg0, 6, b"Hinata", b"Daikokuten AI Agent", x"4461696b6f6b7574656e204149206973206120706c6174666f726d207468617420656d706f776572732063726561746f727320746f206275696c6420616e64206465706c6f79206175746f6e6f6d6f7573204149206167656e74732064657369676e656420746f20726577617264207573657220656e676167656d656e740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qmf_WCQ_Pjp_P8nj8nd3_Ht_Gf_E8r_Rbtcmdb_T_Kjtf8_H_Tj_S6q_M_Gq_6cbae712eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HINATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HINATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

