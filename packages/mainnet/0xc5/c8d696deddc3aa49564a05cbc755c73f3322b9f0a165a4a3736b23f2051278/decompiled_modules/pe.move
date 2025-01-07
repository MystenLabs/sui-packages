module 0xc5c8d696deddc3aa49564a05cbc755c73f3322b9f0a165a4a3736b23f2051278::pe {
    struct PE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PE>(arg0, 9, b"PE", b"Half of PEPE", b"PEP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/YcUzxsUL4wTETS1qWe5HsgCHNaQz9wddcoL2L62xn7k.png?size=lg&key=ac6b2a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PE>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PE>>(v1);
    }

    // decompiled from Move bytecode v6
}

