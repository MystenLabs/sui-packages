module 0xc930137232a641c195b9f1cedd22580de55509786434cfa8863f01b0ec23711d::bluekachu {
    struct BLUEKACHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEKACHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEKACHU>(arg0, 6, b"BLUEKACHU", b"BLUEKACHU SUI", b"$BLUEKACHU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidtd4j3mre736ej5zbiiuxiaddo5ciqg3smvphjx4tpmm22ov3elu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEKACHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEKACHU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

