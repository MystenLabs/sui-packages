module 0x258f19d74653d9a011831db17eb77afa9d304cc72aaff7fafa678f7f92204da8::suilama {
    struct SUILAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMA>(arg0, 6, b"Suilama", b"Suilama On Sui", b"The Official 'Unofficial' Sui Masco", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suilama_50b21c36c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

