module 0xdbd3acc53ee7695cbf2eeb32dad8d421e134708cd1a2f99500b6e05a2f9e0848::asmr {
    struct ASMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASMR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASMR>(arg0, 6, b"ASMR", b"ASMR on SUI", b"the only coin that moans in your ear while it pumps. No locks.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicxz2uu6h3spumlduducc2koy2jpkwhjxnnbmn3pm62iordd4xfm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASMR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASMR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

