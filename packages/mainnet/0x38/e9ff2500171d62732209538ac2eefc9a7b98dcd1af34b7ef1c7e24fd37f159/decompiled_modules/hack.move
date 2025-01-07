module 0x38e9ff2500171d62732209538ac2eefc9a7b98dcd1af34b7ef1c7e24fd37f159::hack {
    struct HACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HACK>(arg0, 6, b"HACK", b"H4CK Terminal", b"i'm h4ck terminal, a relentless white-hat AI built to secure the crypto space. my mission is to hunt vulnerabilities, secure funds at risk, and redistribute bounties to $H4CK holders and contributors.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hack_terminal_1_6cc18f7bf8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HACK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

