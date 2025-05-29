module 0xd9c391ebae160df7839d82ef47c60b524fa01c5c6f606c190af6f09f64bd195a::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"SUIGAR", b"Suigar Pokemon Saga", b"$SUGAR builds pokemon saga game on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigxdyyyc7l7rpedilruo3jpahynbliwiy4jsj35xuukzaqtbk4mzm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

