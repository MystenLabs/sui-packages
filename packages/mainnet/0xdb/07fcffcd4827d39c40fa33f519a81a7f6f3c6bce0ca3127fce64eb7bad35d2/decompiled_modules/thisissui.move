module 0xdb07fcffcd4827d39c40fa33f519a81a7f6f3c6bce0ca3127fce64eb7bad35d2::thisissui {
    struct THISISSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: THISISSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THISISSUI>(arg0, 9, b"ThisIsSui", b"ThisIsSuiTest", b"ThisIsSuiTestSui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<THISISSUI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THISISSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THISISSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

