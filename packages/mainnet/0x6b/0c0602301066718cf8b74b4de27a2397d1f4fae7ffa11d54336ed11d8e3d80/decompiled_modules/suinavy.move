module 0x6b0c0602301066718cf8b74b4de27a2397d1f4fae7ffa11d54336ed11d8e3d80::suinavy {
    struct SUINAVY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAVY>(arg0, 6, b"SuiNAVY", b"SuiNAVY Force", x"546865206669727374204e6176616c20666f726365206f6e2074686520537569204e6574776f726b2e20446576656c6f70656420627920537569204d6178697320666f72204469616d6f6e6420486f6c646572732e200a5265646566696e696e6720746865207374616e646172647320666f72206120646563656e7472616c697a656420616e642073656375726564206d656d6520667574757265206f6e2074686520537569204e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suinavylogo_bb5ff64bf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAVY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAVY>>(v1);
    }

    // decompiled from Move bytecode v6
}

