module 0x9b5801099a0d91fdfac9506664e395d24f4cde7877e9205874e85c3f65a13724::froggyn {
    struct FROGGYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGGYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGGYN>(arg0, 6, b"FROGGYN", b"Sui Froggyn", x"46726f6767796e20776173206c65667420626568696e6420696e20746865207377616d700a4e6f772068697320636f6d696e6720666f7220746865206d6f6f6e62616773", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihziskvbltyvebi2ch5fdwwusxfa5kosxmixm7shbpeevvhp373ea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGGYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FROGGYN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

