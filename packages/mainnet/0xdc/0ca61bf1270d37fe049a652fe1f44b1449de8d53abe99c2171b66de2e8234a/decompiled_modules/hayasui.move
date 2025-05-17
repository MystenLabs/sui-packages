module 0xdc0ca61bf1270d37fe049a652fe1f44b1449de8d53abe99c2171b66de2e8234a::hayasui {
    struct HAYASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAYASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAYASUI>(arg0, 6, b"HAYASUI", b"HAYA SUI", b"SHADOW KILLER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihnkpx2ucatd32dg5arevwcxgdp7z7zbjknxteemsui3n5zodcpoa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAYASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HAYASUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

