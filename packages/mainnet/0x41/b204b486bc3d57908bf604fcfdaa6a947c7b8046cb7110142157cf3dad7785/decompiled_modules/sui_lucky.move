module 0x41b204b486bc3d57908bf604fcfdaa6a947c7b8046cb7110142157cf3dad7785::sui_lucky {
    struct SUI_LUCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_LUCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_LUCKY>(arg0, 9, b"SUI LUCKY", x"f09f8d805375696c75636b79", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_LUCKY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_LUCKY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_LUCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

