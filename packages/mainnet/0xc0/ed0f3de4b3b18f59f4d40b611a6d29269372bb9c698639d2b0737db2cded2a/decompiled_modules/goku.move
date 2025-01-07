module 0xc0ed0f3de4b3b18f59f4d40b611a6d29269372bb9c698639d2b0737db2cded2a::goku {
    struct GOKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOKU>(arg0, 6, b"GOKU", b"goku.meme", x"476f6b75206d656d65206f6e20405375694e6574776f726b2e204c697665206f6e20547572626f732e66756e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731011434837.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

