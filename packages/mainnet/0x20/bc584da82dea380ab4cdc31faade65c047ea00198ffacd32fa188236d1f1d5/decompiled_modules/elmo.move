module 0x20bc584da82dea380ab4cdc31faade65c047ea00198ffacd32fa188236d1f1d5::elmo {
    struct ELMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELMO>(arg0, 6, b"ELMO", b"Elmo on Sui", b"Elmo is the legendary character from the classic TV Show Elmo's World. Inspired by the vision of Sui hype, Elmo left behind his old world and arrived in SUI. Now he is living on the SUI blockchain as a Fan tribute.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734219240388.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELMO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

