module 0xeae1306a1bde99614fd882e07b79120b83307ad05e416592c98e087a68fca79b::pur {
    struct PUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUR>(arg0, 6, b"PUR", b"Sui Pur", b"Hi im $PUR, the coolest cat cruising the SUI network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731071957203.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

