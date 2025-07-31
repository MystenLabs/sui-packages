module 0xba17ed520f8273aee1af0a279d0cad2137e32e9dad206e21c383bf840802edd::plus {
    struct PLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLUS>(arg0, 6, b"PLUS", b"Plus Coin", b"Plus Coin, this is the + in the moonbags launch button.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihamg5sqandlqqlziy6fzouc3zju3h2f73hdvj34ul4pgt6wwkpnm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

