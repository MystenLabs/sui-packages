module 0xe63468780e8e96ec760a9e1b47fd1c0f9961f877a0669f1b084e69be78e25ba4::usdsui {
    struct USDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDSUI>(arg0, 6, b"USDSUI", b"Upside Down SUI", b"The stable meme of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fsml_J_Yo_K_400x400_914aa5e076.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

