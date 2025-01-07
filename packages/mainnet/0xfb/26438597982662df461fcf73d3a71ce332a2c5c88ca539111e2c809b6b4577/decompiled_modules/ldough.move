module 0xfb26438597982662df461fcf73d3a71ce332a2c5c88ca539111e2c809b6b4577::ldough {
    struct LDOUGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDOUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDOUGH>(arg0, 6, b"LDOUGH", b"Lil' Dough", x"537461636b696e672063686970732077697468204c696c2720446f7567682020746865206f6e6c792063757272656e63792074686174206d616b657320796f75722077616c6c6574206c61756768206f7574206c6f7564210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LDOUGH_T_Nj13b_0_Gh_Tv_Kef108k_76a8417946.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDOUGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDOUGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

