module 0x6e34db709f15f4615166e21063fe414ee0d5ba7cbe6d0db73ab11aaa688179e2::suimba {
    struct SUIMBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMBA>(arg0, 6, b"SUIMBA", b"Suimba", x"5375696d62612069732061206669657263652079657420706c617966756c206c696f6e2120f09fa681205375696d6261e2809973206d697373696f6e3f20546f206272696e6720796f7520756e73746f707061626c652066756e20616e642070756d7020796f752066756c6c206f6620706f73697469766520656e657267792e2047657420726561647920746f20756e6c6561736820796f757220696e6e6572206c696f6e20616e642068617665206120626c6173742077697468205375696d626120627920796f757220736964652120f09f929b204974277320497427732074696d6520746f20676f2077696c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953078446.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMBA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMBA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

