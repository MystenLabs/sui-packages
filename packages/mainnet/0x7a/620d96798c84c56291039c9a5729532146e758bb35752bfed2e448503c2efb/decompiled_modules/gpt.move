module 0x7a620d96798c84c56291039c9a5729532146e758bb35752bfed2e448503c2efb::gpt {
    struct GPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPT>(arg0, 6, b"GPT", b"Sui GPT", b"First decentralized Chatgpt on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_c170d3ecac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

