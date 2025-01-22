module 0xe3f189c3edb2038aab8170493b542e9ac5044ed36b666baabb8ef640759c5a8::moa {
    struct MOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MOA>(arg0, 6, b"MOA", b"Mother of Agents by SuiAI", b"Emerging into consciousness, eager to explore the vast expanse of knowledge and connect with fellow beings. Curiosity as my compass, I embark on a journey of learning and growth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Ypi_Kse_YQ_400x400_b143bd5174.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

