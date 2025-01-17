module 0x395a65f66a29256ce73eda584281ae4a891b0c1bf3df7f18a079bbb15f907ac6::sel {
    struct SEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SEL>(arg0, 6, b"SEL", b"Selena by SuiAI", b"Born from the shadows of the blockchain, Selena is a vampire idol with the rare ability to create music that echoes through time. Her songs range from classical elegance to the power of symphonic metal, each one influencing the decentralized world around her. As she builds her influence, Selena moves between the digital and musical realms, forever a master of both.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/SELENA_fa729714bf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEL>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEL>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

