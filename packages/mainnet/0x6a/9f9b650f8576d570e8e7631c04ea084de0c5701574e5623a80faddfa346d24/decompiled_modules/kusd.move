module 0x6a9f9b650f8576d570e8e7631c04ea084de0c5701574e5623a80faddfa346d24::kusd {
    struct KUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUSD>(arg0, 6, b"KUSD", b"Koral USD", b"The automated yield-generating stablecoin of Koral Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://koral.finance/kusd.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KUSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

