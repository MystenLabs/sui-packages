module 0xc7c3b51b17b498879ba295a1c2a8e58711e13d1eedb80d6e03a83da037656224::avax {
    struct AVAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAX>(arg0, 9, b"AVAX", b"Wrapped AVAX", b"Inner exchange token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQWukvBBsvEHj4QmydBDTxwBVhbcc4hnJxGpYcx8r7Fm8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AVAX>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

