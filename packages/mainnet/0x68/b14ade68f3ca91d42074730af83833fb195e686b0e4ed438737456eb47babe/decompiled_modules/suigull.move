module 0x68b14ade68f3ca91d42074730af83833fb195e686b0e4ed438737456eb47babe::suigull {
    struct SUIGULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGULL>(arg0, 6, b"SUIGULL", b"SUIGULL  2.0", x"53554947554c4c2054484520434f4f4c455354204d454d45204f4620414c4c2054494d450a0a52454c41554e43482120436865636b206f6666696369616c204341206f6e2053756967756c6c2e78797a0a0a4a4f494e205447", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1120_414dbb0c7a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

