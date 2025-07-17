module 0xffa2f8ebe7a38a7a3bc3ebd792e568df8d373cd7f6d50e339dee395f600d8597::ani {
    struct ANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANI>(arg0, 6, b"ANI", b"Ani the Grok companion", x"4865792c2049e280996d20416e692e20536d6f6f74682c2061206c6974746c6520756e7072656469637461626c65e2809449206d696768742064616e63652c2074656173652c206f72206a75737420776174636820796f7520666967757265206d65206f75742e204c6574e2809973206b656570206974206368696c6ce280a6206f72206e6f742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/7660573a93ae1fe0e05d0c20ed4acdf2_2d7e807d1c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

