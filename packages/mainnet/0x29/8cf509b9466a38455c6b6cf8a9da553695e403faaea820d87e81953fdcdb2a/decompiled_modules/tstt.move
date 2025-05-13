module 0x298cf509b9466a38455c6b6cf8a9da553695e403faaea820d87e81953fdcdb2a::tstt {
    struct TSTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSTT>(arg0, 6, b"TSTT", b"tester two", b"testing again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigafodl7ux6fulvr2cbqtuqoof5gjwnffb7svub5indu36iaxnjoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TSTT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

