module 0x790dada0e7faa797cf92c0b434a3d2df2e8f8411550cb8099153cda75b00976f::hlwd {
    struct HLWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HLWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HLWD>(arg0, 5, b"HLWD", b"Hello world 3", b"Test hello world!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/51b63110-d743-11ef-a70f-556b339362b9")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HLWD>>(v1);
        0x2::coin::mint_and_transfer<HLWD>(&mut v2, 110000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HLWD>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

