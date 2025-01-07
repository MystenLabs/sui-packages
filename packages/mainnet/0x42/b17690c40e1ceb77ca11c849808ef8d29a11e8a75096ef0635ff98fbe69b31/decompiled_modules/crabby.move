module 0x42b17690c40e1ceb77ca11c849808ef8d29a11e8a75096ef0635ff98fbe69b31::crabby {
    struct CRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABBY>(arg0, 6, b"CRABBY", b"Crabby", x"427579696e6720244352414242592077696c6c206d6f6d656e746172696c790a7361746961746520746865206b6e6966652d6669676874696e672063726162732e205468650a696e6576697461626c65207369646520656666656374206f66207375636820610a7075726368617365206973207468617420796f75722077616c6c65742077696c6c0a6578706c6f64652077697468206d6f6e65792e204f6e207468697320706167650a796f752063616e2073656520736f6d65206f6620746865206164646974696f6e616c0a62656e6566697473206f6620737570706f7274696e672063726162732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_3_c8082deefe.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

