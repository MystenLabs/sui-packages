module 0x10719ae8be700c4ea62298e3eb33104c41ee7f30cc96b1ce8c6ffd8123f91589::suitoru {
    struct SUITORU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITORU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITORU>(arg0, 6, b"Suitoru", b"Suitoru Gojo", b"Domain Expansion: Unlimited Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013953_a028044fbe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITORU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITORU>>(v1);
    }

    // decompiled from Move bytecode v6
}

