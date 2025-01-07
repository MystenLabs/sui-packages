module 0x650a2f96a777fa566e4dc2a1c5739e1d988c485951062f52801c2743ba4e55b0::qode {
    struct QODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QODE>(arg0, 6, b"QODE", b"QODE AI", b"QODE is a multi purpose programming model, meaning that it can be applied to essentially any programming task.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/54345_b69c981b26.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

