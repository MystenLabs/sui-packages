module 0xfa9384372f6c0fb1df1e80ef4e27aca0c0b40df06140d7f799a5be5a96576ed::suikyu {
    struct SUIKYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKYU>(arg0, 6, b"SUIKYU", b"Suikyu Pokemon", b"The first pokemon game on SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibq7brileb3npukkepr4pvvtrsfmavnnvmgawf3t5agd7r627lcsi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKYU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIKYU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

