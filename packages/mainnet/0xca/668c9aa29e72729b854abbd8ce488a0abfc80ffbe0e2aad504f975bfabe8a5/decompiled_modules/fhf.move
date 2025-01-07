module 0xca668c9aa29e72729b854abbd8ce488a0abfc80ffbe0e2aad504f975bfabe8a5::fhf {
    struct FHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FHF>(arg0, 6, b"FHF", b"FUCKTUS HOP FUN", b"FUCK YOU HOP FUN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730972671808.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FHF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FHF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

