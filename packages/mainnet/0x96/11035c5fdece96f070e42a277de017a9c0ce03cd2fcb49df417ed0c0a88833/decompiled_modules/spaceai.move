module 0x9611035c5fdece96f070e42a277de017a9c0ce03cd2fcb49df417ed0c0a88833::spaceai {
    struct SPACEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SPACEAI>(arg0, 6, b"SPACEAI", b"SPACE ORDIMAN AI", b"The first AI AGENT of ROLE PLAY GAME SPACE ORDIMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4586_f373122097.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SPACEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

