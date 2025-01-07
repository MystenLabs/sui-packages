module 0x1b50bf1eb93d707f24447e9ecd7a29fcb987f6ea93d641ffabc073084e30a31::peach {
    struct PEACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACH>(arg0, 6, b"PEACH", b"Princess Peach", b"Hi, Im Princess Peach and i hope Community Take Over me.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/peach_fec06ae6a4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEACH>>(v1);
    }

    // decompiled from Move bytecode v6
}

