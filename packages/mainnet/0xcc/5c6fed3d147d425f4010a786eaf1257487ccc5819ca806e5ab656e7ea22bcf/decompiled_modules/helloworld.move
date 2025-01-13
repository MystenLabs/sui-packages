module 0xcc5c6fed3d147d425f4010a786eaf1257487ccc5819ca806e5ab656e7ea22bcf::helloworld {
    struct HELLOWORLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELLOWORLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HELLOWORLD>(arg0, 6, b"HELLOWORLD", b"Hello World by SuiAI", b"Hello World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ls_ZES_94k_400x400_65a66d82e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HELLOWORLD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELLOWORLD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

