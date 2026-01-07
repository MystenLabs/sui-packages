module 0x9d0a9759b8b1292b05413f3b8412e839e1d1ae1b186b3b81063215a443e54a9e::mmew {
    struct MMEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMEW>(arg0, 9, b"MMEW", b"MoewMoew", b"This is the meme for our moew world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.ag/api/file-upload/96160d2990a61f5d20a4cf51027eacebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMEW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMEW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

