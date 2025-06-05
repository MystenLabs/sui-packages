module 0xc6934707e59e2193c23776dfa37afff25ff2e8626d86d02220880f2f489a3bdc::klye {
    struct KLYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KLYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KLYE>(arg0, 6, b"KLYE", b"Klye coin", b"Let's fuck shit up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifg23ro6hsecbhravvy5xgk5vzx3yzh4cxl6lwqf5zvy6aueutfdq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KLYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KLYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

