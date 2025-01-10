module 0x6e6904c8f4d95e807d5b7346c2edf8ce6fad2281503d8c42970260cf2fba3d34::aizui {
    struct AIZUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIZUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIZUI>(arg0, 6, b"AIZUI", b"ai16zui by SuiAI", b"AIZUI is a cutting-edge AI agent built on the Sui blockchain, designed to revolutionize the way users interact with decentralized intelligence...By leveraging Sui's powerful infrastructure, A6ZUI aims to provide seamless, intelligent solutions for the Web3 community...Our mission is to bridge the gap between artificial intelligence and blockchain technology, making AI capabilities accessible to everyone on the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ai16z_588e7b4c89.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIZUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIZUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

