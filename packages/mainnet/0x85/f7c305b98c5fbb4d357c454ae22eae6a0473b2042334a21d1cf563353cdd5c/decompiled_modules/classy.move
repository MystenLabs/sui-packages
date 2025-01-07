module 0x85f7c305b98c5fbb4d357c454ae22eae6a0473b2042334a21d1cf563353cdd5c::classy {
    struct CLASSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLASSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLASSY>(arg0, 6, b"CLASSY", b"Suited Cat", b"Stay Classy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9205_6832997423.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLASSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLASSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

