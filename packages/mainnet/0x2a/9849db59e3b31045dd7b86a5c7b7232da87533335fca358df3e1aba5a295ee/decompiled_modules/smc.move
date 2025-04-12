module 0x2a9849db59e3b31045dd7b86a5c7b7232da87533335fca358df3e1aba5a295ee::smc {
    struct SMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMC>(arg0, 9, b"SMC", b"SmoothCoin", b"moothCoin (SMC) is an innovative digital asset built on the Sui blockchain, aiming to revolutionize the beauty and personal care industry, particularly in hair removal and skincare. Leveraging Sui's high transaction speed and low fees, SMC facilitates seamless value transfer between businesses and consumers. Potential use cases include loyalty programs, decentralized e-commerce for beauty products, support for content creators, and community-driven governance through a DAO. SmoothCoin envisions fostering a more direct, transparent, and rewarding ecosystem within the beauty sector, powered by Sui's robust infrastructure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fc293fc4632657a19e47ccf301daeb9eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

