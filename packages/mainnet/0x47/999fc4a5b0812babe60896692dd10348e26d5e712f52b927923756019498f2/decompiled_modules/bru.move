module 0x47999fc4a5b0812babe60896692dd10348e26d5e712f52b927923756019498f2::bru {
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

