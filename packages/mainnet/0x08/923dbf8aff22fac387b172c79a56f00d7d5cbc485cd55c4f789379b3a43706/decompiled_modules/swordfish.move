module 0x8923dbf8aff22fac387b172c79a56f00d7d5cbc485cd55c4f789379b3a43706::swordfish {
    struct SWORDFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWORDFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWORDFISH>(arg0, 6, b"Swordfish", b"Swordfish on Sui", b"Sleek, fast, and razor sharp. $SWORDFISH cuts through the Sui waters with precision, always aiming for the top of the memecoin chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Swordfish_45dd9535c9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWORDFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWORDFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

