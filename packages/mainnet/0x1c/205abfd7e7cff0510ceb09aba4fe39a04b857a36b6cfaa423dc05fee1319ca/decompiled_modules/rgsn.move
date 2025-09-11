module 0x1c205abfd7e7cff0510ceb09aba4fe39a04b857a36b6cfaa423dc05fee1319ca::rgsn {
    struct RGSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGSN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<RGSN>(arg0, 6, b"RGSN", b"RugScan", b"An advance Ai Agent which enables you to trade memecoins safely by alerting you about the token developper.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/rugscan_90932ad5d0.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RGSN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGSN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

