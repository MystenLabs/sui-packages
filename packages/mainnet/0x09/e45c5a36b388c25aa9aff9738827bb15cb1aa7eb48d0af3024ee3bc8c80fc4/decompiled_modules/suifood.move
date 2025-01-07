module 0x9e45c5a36b388c25aa9aff9738827bb15cb1aa7eb48d0af3024ee3bc8c80fc4::suifood {
    struct SUIFOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFOOD>(arg0, 6, b"SUIFOOD", b"SuiFood", b"Suifood is a decentralized platform built on the Sui blockchain, designed to revolutionize the food industry by leveraging blockchain technology. It aims to enhance transparency, traceability, and trust within the food supply chain. suifood.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_130736_51e738b447.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

