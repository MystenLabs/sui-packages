module 0xa2859d61462635912553746e1b28a54e90b6ad6270f1e7c7db73761a9d6ba1e1::scallop_xbtc {
    struct SCALLOP_XBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCALLOP_XBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCALLOP_XBTC>(arg0, 8, b"sXBTC", b"sXBTC", b"Scallop interest-bearing token for xBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://q7xjiqhsxhupedtu73thbyldz2abjo4xc2scrtiew3sfqgk4oasq.arweave.net/h-6UQPK56PIOdP7mcOFjzoAUu5cWpCjNBLbkWBlccCU")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCALLOP_XBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCALLOP_XBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

