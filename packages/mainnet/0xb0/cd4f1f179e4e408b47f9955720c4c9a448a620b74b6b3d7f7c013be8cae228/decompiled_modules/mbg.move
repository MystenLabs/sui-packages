module 0xb0cd4f1f179e4e408b47f9955720c4c9a448a620b74b6b3d7f7c013be8cae228::mbg {
    struct MBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBG>(arg0, 6, b"MBG", b"Moneybag", b"Only up from here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigjnxixso42py3lu6ruk4bi3jhtt4cep6kpmvwlznysxlw7oixogy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

