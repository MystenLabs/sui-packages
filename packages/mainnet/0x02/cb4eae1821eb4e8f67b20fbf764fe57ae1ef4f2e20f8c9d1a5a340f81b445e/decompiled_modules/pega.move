module 0x2cb4eae1821eb4e8f67b20fbf764fe57ae1ef4f2e20f8c9d1a5a340f81b445e::pega {
    struct PEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEGA>(arg0, 6, b"PEGA", b"PEGA SUI", b"With its unique art style and offbeat humor, \"PEGA\" captures the essence of Mall Furie creative vision and showcases the lovable charm of the $PEGA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731047316944.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

