module 0xbf017b537abaeb635496b24e0647fca1c636a578a10e965075b6f9c201893e0::ghost {
    struct GHOST has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHOST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHOST>(arg0, 6, b"GHOST", b"GhostChain", x"47686f7374436861696e20e698afe4b880e4b8aae59fbae4ba8ee58cbae59d97e993bee79a84e9a1b9e79baeefbc8ce697a8e59ca8e9809ae8bf87e5889be696b0e5928ce5b9bde9bb98e5b086e695b0e5ad97e8b584e4baa7e4b896e7958ce4b88ee9acbce9ad82e7a59ee7a798e9a286e59f9fe79bb8e7bb93e59088e38082e68891e4bbace78bace789b9e79a8447484f5354e4bba3e5b881e5b086e59ca8e4b880e4b8aae58585e6bba1e5b9bbe683b3e5928ce5b9bde9bb98e58583e7b4a0e79a84e993bee4b88ae7949fe68081e7b3bbe7bb9fe4b8ade6b581e9809ae38082e58aa0e585a5e68891e4bbacefbc8ce4bd93e9aa8ce5898de68980e69caae69c89e79a84e794b5e5ad90e5b9bde781b5e4b896e7958cefbc81", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731302406837.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHOST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHOST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

