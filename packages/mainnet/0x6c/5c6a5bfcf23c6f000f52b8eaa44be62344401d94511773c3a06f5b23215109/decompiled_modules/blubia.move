module 0x6c5c6a5bfcf23c6f000f52b8eaa44be62344401d94511773c3a06f5b23215109::blubia {
    struct BLUBIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBIA>(arg0, 6, b"BLUBIA", b"BLUBIAonSUI", x"205769666520616e642074686520726569676e696e6720515545454e206f662074686520535549204f4345414e2121210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUB_c2e66bd594.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

