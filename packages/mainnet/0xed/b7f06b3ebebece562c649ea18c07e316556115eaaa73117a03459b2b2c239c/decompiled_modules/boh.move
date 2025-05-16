module 0xedb7f06b3ebebece562c649ea18c07e316556115eaaa73117a03459b2b2c239c::boh {
    struct BOH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOH>(arg0, 6, b"BOH", b"Book Of Hold", b"You buy. You don't sell. You hold. You WIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibsuexcci2hesq4mtcqkeyadk5rj6jgrvebsvjcikw6ffsctzfhm4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

