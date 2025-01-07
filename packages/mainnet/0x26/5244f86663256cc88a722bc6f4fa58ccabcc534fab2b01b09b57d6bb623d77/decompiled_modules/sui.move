module 0x265244f86663256cc88a722bc6f4fa58ccabcc534fab2b01b09b57d6bb623d77::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 2, b"SUI", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets-global.website-files.com/6425f546844727ce5fb9e5ab/643773c0d96a22a83c5baf48_Sui_Favicon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<SUI>>(v0);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

