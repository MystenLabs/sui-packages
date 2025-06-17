module 0x85abba6ab1b54ffb4144dbf941b8c23d81d6384d19a45ffecfd1cf0538d4bdda::kusd {
    struct KUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUSD>(arg0, 6, b"kUSD", b"Koral USD", b"The automated yield-generating stablecoin of Koral Finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://koral.finance/kusd.png"))), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KUSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

