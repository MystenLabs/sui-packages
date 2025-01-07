module 0x87434f20c41cba5160b263dd21933598816ba1156df0a9e7e2abddc26003041c::piss {
    struct PISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISS>(arg0, 6, b"PISS", b"Piss", b"The official coin of Piss", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731107263610.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PISS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

