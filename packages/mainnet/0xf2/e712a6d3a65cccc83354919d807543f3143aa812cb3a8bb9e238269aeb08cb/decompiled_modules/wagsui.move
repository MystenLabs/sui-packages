module 0xf2e712a6d3a65cccc83354919d807543f3143aa812cb3a8bb9e238269aeb08cb::wagsui {
    struct WAGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGSUI>(arg0, 9, b"WAGsui", b"WAGSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761305763/sui_tokens/kcccmdposbtajzb8mwch.avif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WAGSUI>>(0x2::coin::mint<WAGSUI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAGSUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WAGSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

