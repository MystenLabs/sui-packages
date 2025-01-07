module 0x79cb714e1df204678603a870da354af7282211113307421e4fbfd014bd333084::llama {
    struct LLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMA>(arg0, 6, b"LLAMA", b"LLAMASUI", b"LLAMA IS COMING TO SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/efffffdba2624278dc89022400540ffd_6a85e220b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

