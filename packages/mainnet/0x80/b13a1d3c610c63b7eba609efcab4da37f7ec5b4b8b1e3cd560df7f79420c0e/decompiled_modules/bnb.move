module 0x80b13a1d3c610c63b7eba609efcab4da37f7ec5b4b8b1e3cd560df7f79420c0e::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"Behind No Bars", b"CZ  Is free and not behind bars anymore lets moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BNB_beddc2288e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNB>>(v1);
    }

    // decompiled from Move bytecode v6
}

