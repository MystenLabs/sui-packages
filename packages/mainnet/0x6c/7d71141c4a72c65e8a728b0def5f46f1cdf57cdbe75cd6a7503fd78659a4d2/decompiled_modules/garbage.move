module 0x6c7d71141c4a72c65e8a728b0def5f46f1cdf57cdbe75cd6a7503fd78659a4d2::garbage {
    struct GARBAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARBAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARBAGE>(arg0, 6, b"GARBAGE", b"Are u Garbage?", x"4c6f6f6b73206c696b65205472756d70206973206a7573742061732070726f756420746f2062652047415242414745206173207468652072657374206f66207573210a0a2447415242414745", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049188_9e4ad37db2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARBAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARBAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

