module 0x20930456b56169e81ce106e9a572f95fefada943af36eebc6deffd3aa34687ae::size {
    struct SIZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIZE>(arg0, 6, b"SIZE", b"SIZE TOKEN", b"Risk-taker, burger lover, crypto degen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibb4p264ntr6fu6syivv5hm76coms52szbiqkxac6n6sxjrneja34")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIZE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

