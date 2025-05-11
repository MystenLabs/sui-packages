module 0x622ef0b775ffeb283dc2c849435fea0ee53a1aac0925dcabee3b71ba6da4abe6::pirdog {
    struct PIRDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIRDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIRDOG>(arg0, 6, b"PIRDOG", b"Pirates Dog", b"Just a pirates dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000068820_89fa60bd46.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIRDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIRDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

