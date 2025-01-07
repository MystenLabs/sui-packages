module 0xefc8160182bc441e9047893050525ce4d72c6a6a25a3ed211c57fe6d9338632d::SEABDSS {
    struct SEABDSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEABDSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEABDSS>(arg0, 9, b"SEABDSS", b"SEABDSS", b"SEABDSS On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipns/k51qzi5uqu5dltquclsw5m7y2mlo9haoai7p4gxae47l04wsx0twi6shqsk3oy")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEABDSS>>(v1);
        0x2::coin::mint_and_transfer<SEABDSS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEABDSS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

