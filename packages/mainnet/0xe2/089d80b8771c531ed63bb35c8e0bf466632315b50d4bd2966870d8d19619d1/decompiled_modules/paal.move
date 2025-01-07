module 0xe2089d80b8771c531ed63bb35c8e0bf466632315b50d4bd2966870d8d19619d1::paal {
    struct PAAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAAL>(arg0, 6, b"PAAL", b"PAAL AI", b"Powerful AI ecosystem built using Custom Data Feed and LLMs. Personalize your AI & share across all web platforms. Paal's suite includes PaalX for seamless trading and wallet management, PaalBetBot for integrated sports betting, and autonomous agents for advanced analytics and task automation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003206_b74ad74483.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAAL>>(v1);
    }

    // decompiled from Move bytecode v6
}

