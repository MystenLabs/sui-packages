module 0xc06cda8e7f8a87d8c0ffecf7aeaa2bdfd665bc73a9eaec333d6f2f11e6ddde80::airos {
    struct AIROS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIROS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIROS>(arg0, 6, b"AIROS", b"AIROS AI by SuiAI", b"Decentralized AI robot harnessing Sui Network's cutting-edge blockchain technology..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Pv6qew9_400x400_accf6313ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIROS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIROS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

