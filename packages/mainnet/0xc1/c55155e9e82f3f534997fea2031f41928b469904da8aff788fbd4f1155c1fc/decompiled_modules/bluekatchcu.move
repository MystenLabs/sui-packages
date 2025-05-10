module 0xc1c55155e9e82f3f534997fea2031f41928b469904da8aff788fbd4f1155c1fc::bluekatchcu {
    struct BLUEKATCHCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEKATCHCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEKATCHCU>(arg0, 6, b"BLUEKATCHCU", b"BLUEKATCHU SUI", b"BLUE KATCHU-KATCHU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiddjpjdknmqlyzgwk3yl5mpt66egbtcgswza6dgr2dhbcf7ojx7uq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEKATCHCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEKATCHCU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

