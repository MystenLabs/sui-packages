module 0x8ae1f0031e3ae5e220852134b981e187efc6c56245b8927111221a85b01a5ae5::fries {
    struct FRIES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRIES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRIES>(arg0, 6, b"FRIES", b"just put my fries in the bag bro", x"73746f7020616c6c2074686973206273206a75737420707574206d7920667269657320696e20746865206261672062726f0a62792062726f6b69652063756c74757265", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241215_003933_059_be066cb3ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRIES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRIES>>(v1);
    }

    // decompiled from Move bytecode v6
}

