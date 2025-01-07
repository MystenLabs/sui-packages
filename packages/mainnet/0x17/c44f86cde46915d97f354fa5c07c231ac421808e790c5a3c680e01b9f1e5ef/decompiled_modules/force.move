module 0x17c44f86cde46915d97f354fa5c07c231ac421808e790c5a3c680e01b9f1e5ef::force {
    struct FORCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FORCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORCE>(arg0, 6, b"FORCE", b"ForceAI", b"ForceAI is the next-generation AI-powered token designed to revolutionize decentralized ecosystems through advanced artificial intelligence and blockchain integration.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734459201805.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORCE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORCE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

