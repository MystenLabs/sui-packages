module 0xd25d319cf8d86595e89cefd69a5d7d5df92b7ebc2193cf3d1722f000e43d8dd3::hpd {
    struct HPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPD>(arg0, 6, b"HPD", b"HOPDOG", b"$HOPDOG, Sui's and Hop's best dog! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730953602799.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HPD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

