module 0x6a027700aedabe313a44c80e26b1a687d2476776f7d774ae0c6a348777f6c914::bluf {
    struct BLUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUF>(arg0, 6, b"BLUF", b"BLUFINN", b"BLUFINN is a meme coin on SUI blockchain,inspired by FINN from Adventure Time.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1615_597f5d7c44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

