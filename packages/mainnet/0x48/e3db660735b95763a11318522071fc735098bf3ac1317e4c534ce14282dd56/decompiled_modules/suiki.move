module 0x48e3db660735b95763a11318522071fc735098bf3ac1317e4c534ce14282dd56::suiki {
    struct SUIKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKI>(arg0, 6, b"SUIKI", b"KIKI on Sui", b"KIKI utilizes Sui's high-speed and scalable infrastracture to offer low-cost transactions and seamless cross-chain capabilities between Solana and Sui Ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735450283675.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIKI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

