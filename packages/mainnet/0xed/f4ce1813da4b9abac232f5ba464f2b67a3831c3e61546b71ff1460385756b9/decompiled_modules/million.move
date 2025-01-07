module 0xedf4ce1813da4b9abac232f5ba464f2b67a3831c3e61546b71ff1460385756b9::million {
    struct MILLION has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILLION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILLION>(arg0, 6, b"MILLION", b"Million Ape", b"Just ape to million", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730984836101.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MILLION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILLION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

