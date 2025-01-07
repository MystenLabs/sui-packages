module 0x748986a085aa8d14f2c9bcd15733f516062aecc8c18662858b5ee9e8d64c82f8::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"JobsAI", b"JobsAI is an innovative job listing platform built for the crypto space, designed to connect talent with opportunities across the blockchain industry. Powered by the SUI Network, JobsAI ensures secure, efficient, and decentralized recruitment process", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736227995573.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

