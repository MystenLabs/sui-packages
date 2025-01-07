module 0x726fb5fa52f934418c25b580949be1b271e9d34e4b7cf0ee1629ccb976ee28e0::sw {
    struct SW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SW>(arg0, 6, b"SW", b"SuperWeed", b"Weed That's takes you to the other side of Uranus ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/received_423178362490710_073bcabb5e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SW>>(v1);
    }

    // decompiled from Move bytecode v6
}

