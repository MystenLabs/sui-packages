module 0xed2356aae4262a9b84b909f3c1374c4a9bbd8d873be83bebb4992410e56a20ae::whiskers {
    struct WHISKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHISKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHISKERS>(arg0, 6, b"WHISKERS", b"Whiskers", x"576869736b6572732c2074686520726f756e642d66616365642077616e64657265722e204b6565706572206f6620736563726574732c2064616e63657220756e646572206d6f6f6e6c696768742c20636f6d70616e696f6e20746f2073686f6f74696e672073746172732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Juq_Pj_Eh_400x400_4f5b28e7ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHISKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHISKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

