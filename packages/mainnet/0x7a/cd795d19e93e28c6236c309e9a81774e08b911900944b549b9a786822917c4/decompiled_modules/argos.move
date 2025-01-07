module 0x7acd795d19e93e28c6236c309e9a81774e08b911900944b549b9a786822917c4::argos {
    struct ARGOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARGOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARGOS>(arg0, 6, b"ARGOS", b"Argos", b"Argos Token (ARGOS), is a community-driven cryptocurrency on the Sui Blockchain. Inspired by the loyalty and courage of dogs, it powers AI, Web3, gaming, DeFi, NFTs, and payments, aiming for global adoption and redefining blockchain's future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734919638890.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ARGOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARGOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

