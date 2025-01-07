module 0x4e0c0cec96fc21037295135e11ade5c75cebdb2c39c80871dac608b9ecdb3f07::e {
    struct E has drop {
        dummy_field: bool,
    }

    fun init(arg0: E, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<E>(arg0, 6, b"E", b"MUI", b"When you see it, take it, share it, give it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m_cc7de8b64b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<E>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<E>>(v1);
    }

    // decompiled from Move bytecode v6
}

