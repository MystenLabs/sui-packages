module 0x258be870f7561bffa8e9f284c1076347bdc4984ddc4dc35380860305de7afba7::htr {
    struct HTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HTR>(arg0, 6, b"HTR", b"Hopper the rabbit", x"5468652066617374657374206372656174757265206f6e200a405375696e6574776f726b0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hoper_3255117352.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

