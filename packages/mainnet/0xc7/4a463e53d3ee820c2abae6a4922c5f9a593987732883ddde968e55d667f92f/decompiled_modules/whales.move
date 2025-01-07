module 0xc74a463e53d3ee820c2abae6a4922c5f9a593987732883ddde968e55d667f92f::whales {
    struct WHALES has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALES>(arg0, 6, b"Whales", b"KING WHALES", b"Enter to the group.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGO_AVEC_TITRE_3c8d7f6cf5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALES>>(v1);
    }

    // decompiled from Move bytecode v6
}

