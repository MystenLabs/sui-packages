module 0x612dcc39ee33411c1c5fbcae7de5c7d6ceb3864d93ee9a64ffd6fe8f7fbf9371::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"SUISAGA", x"506c617965727320636f6d706574652077697468206f7468657220706c617965727320696e206d6172626c652072616365732c20636f6d6d756e69636174652c20616e64206265636f6d652077696e6e657273202620676574207265776172646564206f6e20244d4152424c45532e2047616d6520646576656c6f70656420627920536167612e20535549204e6574776f726b2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_13_37_44_055cb0be23.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

