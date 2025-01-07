module 0xb85869468577e675f82c46472afe1cf55ebddbe5edefdbd7cec19d6ea8bc891::fff {
    struct FFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFF>(arg0, 6, b"FFF", b"Famous Fox Federation on SUI", b"Sales alerts from Tensor, Magic Eden, and FoxySwap", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0ofm8_Z6m_400x400_7de9d186f7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

