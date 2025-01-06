module 0x539fbae3559219d555f5578ad65e4f17f54b521f9edb6f9fc804882675961f77::boots {
    struct BOOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOTS>(arg0, 6, b"BOOTS", b"BOOTSUI", x"424f4f54535549206f6e2053554921202d20467574757265204b696e67206f66204d656d65636f696e73206f6e205355492e0a4261736564206f6e204465762773204361742e0a436f6d706c6574656c79206f726967696e616c20746f6b656e2026206f6e6c79206f6e205355492e0a424f4f545355492e204c46472121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BOOTSUI_5c5409adab.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

