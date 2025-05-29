module 0xad00f22c908145c87babf6edfd0803dbace1b7385be9c253627c4601518ea320::movegold {
    struct MOVEGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVEGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVEGOLD>(arg0, 6, b"MOVEGOLD", b"MovePump Gold", b"MovePump Gold - is the latest revolution from MovePump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000074531_02c1bb1516.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVEGOLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVEGOLD>>(v1);
    }

    // decompiled from Move bytecode v6
}

