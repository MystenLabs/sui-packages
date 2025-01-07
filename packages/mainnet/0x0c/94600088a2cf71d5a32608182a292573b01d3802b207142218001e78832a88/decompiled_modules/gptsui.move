module 0xc94600088a2cf71d5a32608182a292573b01d3802b207142218001e78832a88::gptsui {
    struct GPTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPTSUI>(arg0, 6, b"GPTsui", b"Sui GPT", b"First decentralized Chatgpt on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_c170d3ecac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GPTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

