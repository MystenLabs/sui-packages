module 0x902e21b2e4bad038bd442157c449d65ba436351659155952ab080c2f1b40ab43::pefish {
    struct PEFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEFISH>(arg0, 6, b"PEFISH", b"PEFISH on Sui", x"496e2074686520776f726c64206f66206d656d65732c2077686572652066726f67730a617265207769736520616e642066756e6e792c2061206e6577206865726f0a61707065617265643a2050657061792e2042757420506570617920776173206e6f0a6f7264696e61727920506570653b206865206861642061207370656369616c0a6d697373696f6e20746f206d6978207468652066756e206f66206d656d65730a77697468207468652065617365206f6620706179696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fj_F_Gx_X36q_X_2_999ad1fb33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

