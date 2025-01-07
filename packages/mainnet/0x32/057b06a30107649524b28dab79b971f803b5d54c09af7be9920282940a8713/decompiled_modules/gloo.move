module 0x32057b06a30107649524b28dab79b971f803b5d54c09af7be9920282940a8713::gloo {
    struct GLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLOO>(arg0, 6, b"GLOO", b"Axolotl Gloo", b"Gloo is like a tiny, wobbly sky drop with legs! Big eyes, stubby little feet, and a clumsy charm that makes her irresistibly cute.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_18_49_04_3acae0a469_fbf6755893.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

