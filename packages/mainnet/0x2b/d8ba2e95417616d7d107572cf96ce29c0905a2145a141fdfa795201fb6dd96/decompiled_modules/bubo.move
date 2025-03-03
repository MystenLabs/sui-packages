module 0x2bd8ba2e95417616d7d107572cf96ce29c0905a2145a141fdfa795201fb6dd96::bubo {
    struct BUBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBO>(arg0, 6, b"BUBO", b"BUBO ON SUI", b"Crypto Bubbles Map for Multichain  Track real-time token prices and market trends on the Sui Network with our interactive bubble map.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x5f3c06ac9ff55392b205683870982a2b642a22307b065b96b874a4148dee973a_bubo_bubo_b092f8392e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

