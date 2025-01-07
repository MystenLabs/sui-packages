module 0x73ec29ebc518f6f7c00d8b52a3b8a8f56c9497696360af2389ae0bf0021ae9aa::shell {
    struct SHELL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHELL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHELL>(arg0, 6, b"SHELL", b"SuiShell", b"Sea Shell in SUI world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hand_drawn_pink_sea_shell_illustration_free_vector_5c0ab045f4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHELL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHELL>>(v1);
    }

    // decompiled from Move bytecode v6
}

