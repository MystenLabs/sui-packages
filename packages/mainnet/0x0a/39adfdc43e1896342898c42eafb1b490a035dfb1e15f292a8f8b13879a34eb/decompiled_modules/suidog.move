module 0xa39adfdc43e1896342898c42eafb1b490a035dfb1e15f292a8f8b13879a34eb::suidog {
    struct SUIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDOG>(arg0, 6, b"SUIDOG", b"SUIDOG ", x"546865206d6f7374206f726967696e616c20616e64206261646173732024535549444f472c206d61646520666f72207468652023535549206e6574776f726b2e20204241524b454420617420616c6c206d7920636f70696573f09f9095", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730960936435.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDOG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDOG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

