module 0x31bc328bd4cdc8f1a5d8cdb5438a0c539dcebf47e6e51cd6af5fde4164df497e::volatile {
    struct VOLATILE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLATILE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VOLATILE>(arg0, 6, b"VoLaTiLe", b"Volatile Coin", x"cf83", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1754161871068.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VOLATILE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLATILE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

