module 0x3df706d4e51dd831716d3e9e5b0a3e4e07b0eea86ab281f3553bd67b91728201::marvin {
    struct MARVIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARVIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARVIN>(arg0, 6, b"MARVIN", b"Marvin", b"Marvin is a groundbreaking memecoin on the Sui blockchain, designed to build a strong, active, and engaged community. Our mission is to create an evolving ecosystem where users can collaborate, share ideas, and grow together. We are committed to becoming the top memecoin in the Sui ecosystem with a focus on community strength and innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3mrst9_155b904ee2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARVIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARVIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

