module 0x53b27bb2fc20f6d134b876537a66968f2e2c1fb4940f07cea10b231a16685d85::t270 {
    struct T270 has drop {
        dummy_field: bool,
    }

    fun init(arg0: T270, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T270>(arg0, 6, b"T270", b"Trump270", b"270 Electoral college votes required to win the election for President of the United States of America! Lets follow Trump and get them all!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9685_a180dad899.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T270>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T270>>(v1);
    }

    // decompiled from Move bytecode v6
}

