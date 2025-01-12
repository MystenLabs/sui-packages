module 0xf8db39d7fdb7f116c9b4d7340760c8f7a59f7b2fe0a950c26c0bcd5906a0a862::polaris {
    struct POLARIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLARIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POLARIS>(arg0, 6, b"POLARIS", b"polaris AI by SuiAI", b"Deploy intelligent moderation agents with advanced crypto capabilities. Protect your community from scams, spam, and maintain a secure trading environment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2114_a903f3e058.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLARIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLARIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

