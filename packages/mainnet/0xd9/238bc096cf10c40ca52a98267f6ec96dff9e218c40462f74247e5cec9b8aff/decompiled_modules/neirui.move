module 0xd9238bc096cf10c40ca52a98267f6ec96dff9e218c40462f74247e5cec9b8aff::neirui {
    struct NEIRUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEIRUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEIRUI>(arg0, 6, b"NEIRUI", b"NEIRO GF ON SUI", x"48657920496d204e45495255490a0a4e6569726f2773204746206f6e205375690a0a506c65617365206a6f696e206d65206f6e206d79206a6f75726e657920746f206265636f6d696e67207468652062696767657374204269746368206f6e2053554921210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/neiro_gf_282a35fbea.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEIRUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEIRUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

