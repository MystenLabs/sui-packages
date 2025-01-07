module 0x2674acab30b676a39377fcba4b1b6b6f3c6fcd7af84b256ba260dc7eae9ffb62::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAD>(arg0, 6, b"Sad", b"Sad Cat", b"Enough copy pasta, join the OG gang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0732_82107d6e39.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

