module 0x8dbf7f2ac6a0b2a2dff8d4f608b5e49377ddf2ea44b1d8b2a372943d8f9486e2::macaw {
    struct MACAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MACAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MACAW>(arg0, 6, b"MACAW", b"MacawLabs", b"MacawLabs is a next-generation liquidity bridge built on the Sui blockchain, allowing seamless asset transfers across multiple chains with high efficiency and security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000054087_ef6479a7dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MACAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MACAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

