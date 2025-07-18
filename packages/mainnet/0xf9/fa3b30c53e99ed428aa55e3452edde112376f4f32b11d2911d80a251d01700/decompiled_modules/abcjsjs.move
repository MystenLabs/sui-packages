module 0xf9fa3b30c53e99ed428aa55e3452edde112376f4f32b11d2911d80a251d01700::abcjsjs {
    struct ABCJSJS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCJSJS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCJSJS>(arg0, 6, b"Abcjsjs", b"A", b"Sheydhd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicf4m3gj4gnuw7ly4w44ty55v3hirol5xrxwdvutbwwc7rhras4lm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCJSJS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABCJSJS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

