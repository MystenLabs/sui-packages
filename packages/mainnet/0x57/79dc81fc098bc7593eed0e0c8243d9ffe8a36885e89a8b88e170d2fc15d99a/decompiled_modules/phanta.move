module 0x5779dc81fc098bc7593eed0e0c8243d9ffe8a36885e89a8b88e170d2fc15d99a::phanta {
    struct PHANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PHANTA>(arg0, 6, b"PHANTA", b"PHANTA SUI", b"Merry Christmas to everyone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7060_0e207b9e03.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PHANTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PHANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

