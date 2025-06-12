module 0xbde03011fda42f529c442f666a5c88a4ca3120195fdf4a4107dc042d1e80382f::assd2 {
    struct ASSD2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSD2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASSD2>(arg0, 6, b"ASsd2", b"asd", b"asda11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihwbzpd62k6uh57mjwmnamtm574heuofdmq6k42lwtfnle63qmce4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSD2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASSD2>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

