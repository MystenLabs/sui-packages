module 0xa99c185c3bea33898ef0cb4d3a096af080cef73eb01984a717b7a19a28bc4ab8::lama {
    struct LAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMA>(arg0, 6, b"LAMA", b"LAMA-CTO", b"Lama, a rebellious and disdainful lama, determined to be a meaningful, fun, and fair meme! We introduce Lama to embody the lama spirit, expressing disdain and mockery towards the absurdity of the current meme market. Lama symbolizes the rebellious and free spirit of the llama community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Md_MF_3_Qn6_400x400_eac6c85233_7575a53044.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

