module 0x6907cf519326d3fa3deda3adf3d8eeb966d552141f7e4bee587b903a2fa10ed::grzn {
    struct GRZN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRZN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRZN>(arg0, 6, b"Grzn", b"Grizon", b"GRIZON combines the power of Artificial Intelligence (AI) and Blockchain, merging smart technology with transparency and security to revolutionize how we interact with tech.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2371_3398c24c0a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRZN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRZN>>(v1);
    }

    // decompiled from Move bytecode v6
}

