module 0xeefb77fc84df796fd2e90f7fbcc14fe429427a099fb059543354c2a46cf87219::schat {
    struct SCHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHAT>(arg0, 6, b"Schat", b"suichat", b"suichat  described as a platform that leverages Generative AI and Web3 to empower creators and communities by providing OnChain AI Agents. This platform focuses on enhancing audience engagement and fostering innovative solutions in digital cre", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736919671939.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCHAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

