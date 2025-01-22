module 0x79ac97564aca261a350101c85ade32730d1bbb5deba8fd5a113f31b890b6655b::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"POPO", b"POPO THE DOG", x"506f706f2c2061732061206368617261637465722c2063616d652066726f6d20746865206d656d652063756c7475726520737572726f756e64696e6720506570652c20757375616c6c7920646570696374656420617320686973206375746520616e6420667269656e646c7920646f672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c2a768d8_f37f_4ba1_b736_b6288728eb1e_ccd8f58a57.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

