module 0xc07dd7ced7262d691ca1445dd6b4046df95401772e572c5093ff23dca900e3b6::aicat {
    struct AICAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AICAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AICAT>(arg0, 6, b"AICAT", b"Cat AI Sui Network by SuiAI", b"Cat AI is a unique token on the Sui Network, blending the power of artificial intelligence with the undeniable charm of cats. With the goal of bringing creativity and value to the community, Cat AI is not just an ordinary token but a symbol of entertainme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/w_Ib9q6_AZ_400x400_43f2ce284f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AICAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AICAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

