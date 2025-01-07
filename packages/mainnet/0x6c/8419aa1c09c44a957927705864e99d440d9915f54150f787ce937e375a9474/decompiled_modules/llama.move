module 0x6c8419aa1c09c44a957927705864e99d440d9915f54150f787ce937e375a9474::llama {
    struct LLAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLAMA>(arg0, 6, b"LLAMA", b"Llama Llama Sui", b"Seamlessly connecting blockchains with fast transactions, low fees, and limitless possibilities. The Llama Llama Bridge is your gateway to a unified crypto ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/llamallamasui_58abb870b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LLAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

