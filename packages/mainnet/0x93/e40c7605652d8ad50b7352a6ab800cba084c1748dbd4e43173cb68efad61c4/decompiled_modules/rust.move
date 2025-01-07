module 0x93e40c7605652d8ad50b7352a6ab800cba084c1748dbd4e43173cb68efad61c4::rust {
    struct RUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUST>(arg0, 6, b"RUST", b"Rustie", b"Rustie is our favorite little robo buddy. Rustie got a bit wet from all the water on SUI and needs some help getting oiled up and ready to Go! Join our TG and follow us on X! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3852_052c42bbd4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

