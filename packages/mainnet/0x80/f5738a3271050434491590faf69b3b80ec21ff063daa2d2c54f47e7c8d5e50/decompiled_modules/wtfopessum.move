module 0x80f5738a3271050434491590faf69b3b80ec21ff063daa2d2c54f47e7c8d5e50::wtfopessum {
    struct WTFOPESSUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WTFOPESSUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WTFOPESSUM>(arg0, 6, b"WTFOPESSUM", b"Sui Wtfopessum", b"WTFO IS NOT YOUR REGULAR BORING SOL MEME. WTFO IS DIFFERENT. A UNIQUE CHARACTER LORD POSSUM WHO SUITES THE LEGENDARY ABILITY OF ALL POSSUM. BEING IMMORTAL, BEING RESISTANT AGAINST POISON AND HARM. JUST LIKE OUR TOKEN ON SUI. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000061877_340a72fd64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WTFOPESSUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WTFOPESSUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

