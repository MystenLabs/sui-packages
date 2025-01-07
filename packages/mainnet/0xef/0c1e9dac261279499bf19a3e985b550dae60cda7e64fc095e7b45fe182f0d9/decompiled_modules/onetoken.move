module 0xef0c1e9dac261279499bf19a3e985b550dae60cda7e64fc095e7b45fe182f0d9::onetoken {
    struct ONETOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONETOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ONETOKEN>(arg0, 6, b"ONETOKEN", b"lord of the token", b"The one Token to rule them all", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000042392_fca3855ecd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONETOKEN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONETOKEN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

