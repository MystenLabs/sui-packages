module 0x72d7fdbbf9106d2a9ab7b6808c0bebc8f3cf7cc3ac00e326978163cc247f87f::rusfat {
    struct RUSFAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUSFAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUSFAT>(arg0, 6, b"RUSFAT", b"RusfatTheWalrusFat", b"We are $RUSFAT, Moving on sui network!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000070543_c2cc3efd00.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUSFAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUSFAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

