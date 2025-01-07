module 0xec8bfea948b0ccca0bccfb52af9aed78a294c326663a0097b96577adce8ed1c5::pepenut {
    struct PEPENUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPENUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPENUT>(arg0, 6, b"Pepenut", b"Post nut clarity pepe", b"Pepe had a realization ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7389_26b2b04d30.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPENUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPENUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

