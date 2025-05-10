module 0x797f42298faa293cb0fb7c483b9d0b4eb5d5eda6bf24086d1c75d466bfcb97ee::botify {
    struct BOTIFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTIFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTIFY>(arg0, 6, b"BOTIFY", b"Botify Cloud", b"Expanding now on Sui Network. $BOTIFY is the Shopify of Crypto. AI Agents. Onchain. No-code. Automate everything. Disrupt SaaS. Own the infra. Be early.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih562xpga62wni7dikfixwgmdqmohtqqliffhgedn5bbipve4v25u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTIFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOTIFY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

