module 0xbd53c651e64987a9b581c3fbae7c25b5d223fe1b33d0b3c569f7f161ff70a8bd::leoxiv {
    struct LEOXIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEOXIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEOXIV>(arg0, 6, b"LEOXIV", b"LEONE XIV", b"LEONE XIV on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeibccojt35gyxp3jc62aaebzudwrlei773fygg43yqpuyewwbnhn7m")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEOXIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEOXIV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

