module 0x885a7eb22639124623d360f2088b58309c9b54c239ee6811f565cc86fbc4042e::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"ChickNug", b"One flock, one pump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeic4pu3zq4qoxlhlifclvmv3su7yhztcjesnhwzuvf5j7yop2k7kby")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHICK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

