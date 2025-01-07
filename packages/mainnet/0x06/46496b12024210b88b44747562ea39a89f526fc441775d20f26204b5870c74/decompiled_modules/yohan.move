module 0x646496b12024210b88b44747562ea39a89f526fc441775d20f26204b5870c74::yohan {
    struct YOHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOHAN>(arg0, 6, b"Yohan", b"JOhan", x"4a6f68616e436f696e2069732061206d656d65636f696e20696e73706972656420627920746865206368696c6c696e6720616c6c757265206f66204a6f68616e204c6965626572742066726f6d204d6f6e737465722e204d657267696e67206461726b2070737963686f6c6f676963616c207468656d6573207769746820637279707469632076697375616c732c206974e2809973206120636f6c6c65637469626c6520636f696e20666f722066616e732077686f206170707265636961746520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730469840142.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOHAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOHAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

