module 0x94927e26a8a8dbfbeb5565404ee316cd45bee35a7c2da07412f5d25517c4b318::sei {
    struct SEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEI>(arg0, 6, b"SEI", b"SEIYAN", b"THIS IS SEIYAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007296671.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

