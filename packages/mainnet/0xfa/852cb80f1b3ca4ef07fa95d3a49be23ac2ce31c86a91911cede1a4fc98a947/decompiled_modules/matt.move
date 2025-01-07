module 0xfa852cb80f1b3ca4ef07fa95d3a49be23ac2ce31c86a91911cede1a4fc98a947::matt {
    struct MATT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATT>(arg0, 6, b"MATT", b"MATT FURIE", b"MATT FURIE ON SUI , LETS MAKE HISTORY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_22_20_09_c98c10c579.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATT>>(v1);
    }

    // decompiled from Move bytecode v6
}

