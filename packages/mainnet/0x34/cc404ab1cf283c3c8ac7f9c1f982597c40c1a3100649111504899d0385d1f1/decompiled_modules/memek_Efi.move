module 0x34cc404ab1cf283c3c8ac7f9c1f982597c40c1a3100649111504899d0385d1f1::memek_Efi {
    struct MEMEK_EFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_EFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_EFI>(arg0, 6, b"MEMEKEFI", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_EFI>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_EFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_EFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

