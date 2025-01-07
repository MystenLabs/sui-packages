module 0x86c5b970330b06fe5de21cd139ae6b6a13615d7ba00284e4b47f5f3acb8e711d::tusk {
    struct TUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUSK>(arg0, 6, b"Tusk", b"Tusk the Walrus", x"245455534b2057616c7275732043756c74206f66205375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hiu_QT_Ph_A_400x400_7106d743c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

