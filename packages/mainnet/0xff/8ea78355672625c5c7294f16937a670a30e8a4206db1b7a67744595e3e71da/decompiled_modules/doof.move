module 0xff8ea78355672625c5c7294f16937a670a30e8a4206db1b7a67744595e3e71da::doof {
    struct DOOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOF>(arg0, 6, b"DOOF", b"Real DOOF", b"You just need only $DOOF to get rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibciildjwerkmyojqgx63n522a3wvwtow43wbgpnyyynqrtvjhu3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOOF>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

