module 0x13ebb1347d5dce1b80caa32b567143379089410f564f709cdc679f2b8eb4d005::snacc {
    struct SNACC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNACC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNACC>(arg0, 6, b"SNACC", b"SnaccCoin", b"The YUM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiahmtrxjvuzzmxumohd25ujrlq3uvc35yzrqzwdj53rczlbqh4xau")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNACC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNACC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

