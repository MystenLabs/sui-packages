module 0x27332fef7d9a7b38df63e1952188c2f22777a4e3f57f28530da44385e68d051a::tpump {
    struct TPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPUMP>(arg0, 6, b"TPump", b"Trumpfun", b"Trump Pump Pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734663808021.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

