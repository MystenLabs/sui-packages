module 0x1a48833487698559d2722be400329d96adfa8139a839313581c05a3ec3bdcec3::g21 {
    struct G21 has drop {
        dummy_field: bool,
    }

    fun init(arg0: G21, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G21>(arg0, 6, b"G21", b"g", b"21g", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732617494784.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<G21>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G21>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

