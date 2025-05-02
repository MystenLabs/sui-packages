module 0x7fe9a3cd7aec2a4edbca6f4e197807d4af22fcaab885f01cfc701b73ebd2c64::attn {
    struct ATTN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATTN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATTN>(arg0, 6, b"ATTN", b"AttnToken", x"417474656e74696f6e0a546f6b656e697a65640a5472616e736d697373696f6e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000086959_731fde0003.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATTN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATTN>>(v1);
    }

    // decompiled from Move bytecode v6
}

