module 0xeb15aa4b0b5eb9dd15f608feeb7b1726401270835e69992f13511ee45d4c3281::moondoge {
    struct MOONDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONDOGE>(arg0, 6, b"MOONDOGE", b"MOON DOGE", b"The first dog token fly moonhard on moonbags.io", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidrjkpjv5ptyroha44vnyoygt7mwmrjklfjbzqgvda6x6hqx4jeye")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONDOGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

