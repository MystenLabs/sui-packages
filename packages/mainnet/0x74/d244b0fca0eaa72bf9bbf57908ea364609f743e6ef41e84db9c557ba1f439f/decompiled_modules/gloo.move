module 0x74d244b0fca0eaa72bf9bbf57908ea364609f743e6ef41e84db9c557ba1f439f::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"GLOO", b"Gloo the Axolotl", b"Gloo is like a tiny, wobbly sky drop with legs! Big eyes, stubby little feet, and a clumsy charm that makes her irresistibly cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_18_49_04_3acae0a469_da7f83fe59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

