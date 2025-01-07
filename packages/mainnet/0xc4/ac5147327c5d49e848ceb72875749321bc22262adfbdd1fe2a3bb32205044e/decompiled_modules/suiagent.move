module 0xc4ac5147327c5d49e848ceb72875749321bc22262adfbdd1fe2a3bb32205044e::suiagent {
    struct SUIAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIAGENT>(arg0, 6, b"SUIAGENT", b"SUI AGENT", b"The leading agent on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/sui_ed1bfd47cb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAGENT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAGENT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

