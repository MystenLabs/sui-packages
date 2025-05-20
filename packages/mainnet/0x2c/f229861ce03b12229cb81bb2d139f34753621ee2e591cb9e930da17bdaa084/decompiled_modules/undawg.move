module 0x2cf229861ce03b12229cb81bb2d139f34753621ee2e591cb9e930da17bdaa084::undawg {
    struct UNDAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNDAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNDAWG>(arg0, 6, b"UNDAWG", b"The Undawg", b"Meet the UNDAWG, Everybody loves an undawg story.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia33uxqh7u4zrpy7vjiczqivrzhta4bgwb4xxca2fwb2mbxepajh4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UNDAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<UNDAWG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

