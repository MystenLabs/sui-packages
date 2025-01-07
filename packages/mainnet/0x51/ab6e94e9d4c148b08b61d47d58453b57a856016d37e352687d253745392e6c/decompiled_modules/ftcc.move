module 0x51ab6e94e9d4c148b08b61d47d58453b57a856016d37e352687d253745392e6c::ftcc {
    struct FTCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTCC>(arg0, 6, b"FTCC", b"Floppy The Candle Crusher", x"466c6f707079205468652043616e646c6520437275736865722067616d6521204d616b6520796f7572206f776e20466c6f707079206d656d6520616e64206d616b6520697420666c6f70210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_224608_052_6fd95ddc9e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FTCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

