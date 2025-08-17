module 0x2e8416a3f8b28050dac38f728a926138e87753226263d5234d78452e9e0b34a4::goatzilla {
    struct GOATZILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATZILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATZILLA>(arg0, 6, b"GOATZILLA", b"Goat Zilla", b"Not your ordinary goat, its GOATZILLA!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihlieal2b6kx37y35yyvlq5qu3lvngxs7xpbsddq25rln5y5zisgm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATZILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOATZILLA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

