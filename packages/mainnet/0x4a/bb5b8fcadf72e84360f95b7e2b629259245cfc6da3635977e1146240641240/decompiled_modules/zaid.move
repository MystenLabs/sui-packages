module 0x4abb5b8fcadf72e84360f95b7e2b629259245cfc6da3635977e1146240641240::zaid {
    struct ZAID has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAID>(arg0, 6, b"ZAID", b"ZEREPOOCH AI DOG", x"57656c636f6d6520746f2074686520696d6d65727369766520414920574f524c44206f66205a455245504f4f43482e20546869732077696c6c206265206120706c61636520666f722074686520414920444f475320746f2062726565642e204d7920666174686572205a45524542524f206861732062726f75676874206d6520746f206c696665200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241203_195724_652_0c03dde084.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAID>>(v1);
    }

    // decompiled from Move bytecode v6
}

