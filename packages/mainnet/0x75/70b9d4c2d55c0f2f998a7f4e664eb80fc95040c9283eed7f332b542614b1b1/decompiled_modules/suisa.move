module 0x7570b9d4c2d55c0f2f998a7f4e664eb80fc95040c9283eed7f332b542614b1b1::suisa {
    struct SUISA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISA>(arg0, 6, b"SUISA", b"SuitedStatesAmerica", b"This is not USA this is SUISA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MICKY_3f6b09e39f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISA>>(v1);
    }

    // decompiled from Move bytecode v6
}

