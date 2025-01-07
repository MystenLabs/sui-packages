module 0xb51fb16e60d074de1278a17ab7304322400dbbc209001d967f1e205b6cdfccd4::rpump {
    struct RPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RPUMP>(arg0, 6, b"RPump", b"Rugged Pump", b"Server is down... error 404.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rugged_pump_fea0d18ffc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

