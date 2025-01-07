module 0x18633d7dbf3caa603465a423065249e8c155e6a53110dc34076251db3b9ab251::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 6, b"IUS", b"NOTSUI", x"426520612070617274206f66204955532c20676574206c696d69746564204578636c757369766520436f696e7320696e20746865206c61756e6368206f66204d4f564550554d502e200a0a0a4c65742773206275696c6420746f676574686572210a0a5468616e6b20796f7520666f7220737570706f7274696e672049555321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000102238_c60efed98a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

