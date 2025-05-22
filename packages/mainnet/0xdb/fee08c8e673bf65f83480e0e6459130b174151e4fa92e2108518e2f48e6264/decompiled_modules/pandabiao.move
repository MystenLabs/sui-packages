module 0xdbfee08c8e673bf65f83480e0e6459130b174151e4fa92e2108518e2f48e6264::pandabiao {
    struct PANDABIAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDABIAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PANDABIAO>(arg0, 6, b"PANDABIAO", b"PANDA the King caller of low caps.", b"Panda is the known caller of all low caps in SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifnhokho7e7eydsodlqxnvk5g4xiukpzm2qqfflfzhelztg3qzt34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDABIAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PANDABIAO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

