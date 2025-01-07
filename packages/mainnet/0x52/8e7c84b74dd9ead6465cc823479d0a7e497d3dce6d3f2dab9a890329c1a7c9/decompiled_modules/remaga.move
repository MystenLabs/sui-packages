module 0x528e7c84b74dd9ead6465cc823479d0a7e497d3dce6d3f2dab9a890329c1a7c9::remaga {
    struct REMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: REMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REMAGA>(arg0, 6, b"REMAGA", b"REMAGA SUI", b"REMAGA making America great again, AGAIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730961394752.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<REMAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REMAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

