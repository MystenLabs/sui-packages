module 0x578a4f5d6e252ba1f6cb39476f835aef8a217768cee96b6929a9dc5984d0657f::ssa {
    struct SSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SSA>(arg0, 6, b"SSA", b"SquidSui by SuiAI", x"496e20612063727970746f20776f726c64207768657265206f6e6c792074686520626f6c64207468726976652c2053717569642053756920414920656d6572676564e28094616e2041492d706f776572656420746f6b656e207769746820612077697474792c206d697363686965766f75732073717569642c2053717569644d61737465722c2064657369676e656420746f2068656c7020796f752077696e206269672e204173207468652053756920626c6f636b636861696e20677265772c20537175696420537569204149206e6565646564206d6f726520706c61796572732e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_5732_1_optimized_1000_35bbc46659.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

