module 0xf5179623b4bb338f50a050c85456e5ded88d5b5e89e78443e4047eda02b1d5b9::otin {
    struct OTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTIN>(arg0, 6, b"OTIN", b"Otin Iwaju", b"Follow Otin to the futuristic Lagos, Nigeria.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032121_d5188b24d4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

