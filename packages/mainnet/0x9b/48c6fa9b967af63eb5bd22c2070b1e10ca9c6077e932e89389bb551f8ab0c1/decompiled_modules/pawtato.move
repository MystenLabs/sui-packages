module 0x9b48c6fa9b967af63eb5bd22c2070b1e10ca9c6077e932e89389bb551f8ab0c1::pawtato {
    struct PAWTATO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO>(arg0, 6, b"Pawtato", b"Pawtato bot", b"Pawtato Bot is your ultimate companion for the Sui Blockchain. With powerful tools and utilities rolling out soon, it's designed to give you an edge in the world of DeFi and beyond.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241124_004910_702_da48defa8b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWTATO>>(v1);
    }

    // decompiled from Move bytecode v6
}

