module 0x58e47e525934ba789812c5839e816f3563ce896ee9953cb4bd34d0911ef4fb1a::trump_sui {
    struct TRUMP_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP_SUI>(arg0, 9, b"TRUMP SUI", b"TRUMP SUI", b"trump on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMP_SUI>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMP_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMP_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

