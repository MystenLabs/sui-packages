module 0x9318e728fec929b93f1066431a7b308315aadf05344a7d5424b18cbfdeae7605::bru {
    struct BRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRU>(arg0, 6, b"BRU", b"Brulee", b"Let's stick together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bbbbbbbbbbbbbbbbbbbb_c979b6eaf4.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

