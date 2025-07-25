module 0xecb2529f0855bc8d6afb714cc642c94258009513b2f0b45e300c378335c9a7f::ostein {
    struct OSTEIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: OSTEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OSTEIN>(arg0, 6, b"OStein", b"OzempStein", b"EPSTEIN APPROVED", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiglil72b4x2kvgq7yypnbv3i4zthbb7p7jqy7ydjjw5gexzb5orzi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OSTEIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OSTEIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

