module 0x1871919d60dd6c0032ce770ff9c88681a2616e31bea78482526dd5c988e3a872::suited {
    struct SUITED has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITED>(arg0, 6, b"Suited", b"Suited on Sui", x"54686520436f696e20546861747320416c7761797320696e205374796c65210a53686172702c20666173742c20616e64206275696c74206f6e2074686520537569206e6574776f726b2c2053756974656420636f6d62696e657320706572666f726d616e63652077697468206120746f756368206f6620636c6173732e20496e7370697265642062792074686520656c6567616e6365206f662061206d616e20696e2061207065726665637420737569742c206974732074686520746f6b656e2074686174206b6565707320796f757220706f7274666f6c696f206c6f6f6b696e67207368617270", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Schermafbeelding_2024_12_19_143058_ab7163534b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITED>>(v1);
    }

    // decompiled from Move bytecode v6
}

