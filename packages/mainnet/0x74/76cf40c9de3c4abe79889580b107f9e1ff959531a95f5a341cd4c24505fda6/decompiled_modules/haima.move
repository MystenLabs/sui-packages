module 0x7476cf40c9de3c4abe79889580b107f9e1ff959531a95f5a341cd4c24505fda6::haima {
    struct HAIMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAIMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAIMA>(arg0, 6, b"HAIMA", b"SUIHORSE", b"Seahorse Haima, in the Sui blockchain ocean, unearths the treasures hidden at the bottom of the ocean and presents the hidden treasures to You. Social Platform and Web3 project for New crypto news and Airdrops on Sui Blockchain with any wallet. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731347937116.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAIMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAIMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

