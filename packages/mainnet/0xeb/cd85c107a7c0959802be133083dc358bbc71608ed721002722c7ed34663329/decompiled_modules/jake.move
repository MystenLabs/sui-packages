module 0xebcd85c107a7c0959802be133083dc358bbc71608ed721002722c7ed34663329::jake {
    struct JAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAKE>(arg0, 6, b"JAKE", b"Sui Jake", b"Jakeis more than just a meme coin  its a symbol of ambition and determination in the rapidly growing cryptocurrency space. As an active part of the Sui ecosystem, Jake brings a fresh and bold approach to decentralized finance, backed by a community that believes in the power of togetherness and growth. Together, were opening a new chapter in digital assets.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul42_20241226175425_a74e0c7185.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

