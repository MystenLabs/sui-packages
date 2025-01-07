module 0x275e3e58a0a326325d10cc498e7569f73fd4117bc1ab7108a233eec912102b57::pelfort {
    struct PELFORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PELFORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PELFORT>(arg0, 6, b"PELFORT", b"Pelfort Sui", b"Meme coin sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000390_1fcdf3b027.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PELFORT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PELFORT>>(v1);
    }

    // decompiled from Move bytecode v6
}

