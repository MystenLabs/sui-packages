module 0xcfce077cd94a5cc4ac66306a18d62261a2805c3d3368a26817dc4ba44526cc7::ikachu {
    struct IKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IKACHU>(arg0, 6, b"IKACHU", b"Ikachu", b"Part Pikachu, Part Tentacle, All Fun.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747261806837.58")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IKACHU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKACHU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

