module 0x45f7781dee3aad9dcfaf7c47a376182ce08b7cd88b16b9d9eee81dd03a62de73::mash {
    struct MASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASH>(arg0, 9, b"MASH", b"Mobile Army Surgical Hospital", b"For MASHERS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://drive.google.com/file/d/1N1La1gf87XtB4kyAzZzQwWW79-CNslsy/view?usp=drive_link")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MASH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASH>>(v2, @0xb92f8f7dfe6718c11a2f4d8b842331bf86a621fed1f6ec3c4901e05ebaf51bc2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

