module 0x38c62605c75464600b4ff9c3d88062b43a7229092682e47474744819d53b81be::suiw {
    struct SUIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIW>(arg0, 6, b"Suiw", b"Suiwitcat", b"Suuuuui witch cat, give magic everything", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9766_24ab3b80d1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

