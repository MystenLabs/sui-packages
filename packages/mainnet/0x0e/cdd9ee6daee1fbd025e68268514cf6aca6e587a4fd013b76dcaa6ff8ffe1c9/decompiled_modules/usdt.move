module 0xecdd9ee6daee1fbd025e68268514cf6aca6e587a4fd013b76dcaa6ff8ffe1c9::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USDT>(arg0, 6, b"USDT", b"Tether USD", b"Tether (USDT) is a blockchain-based cryptocurrency whose tokens in circulation are backed by an equivalent amount of US dollars, making it a stablecoin with a price pegged to USD $1.00.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tether_usdt_logo_a4e238924d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

