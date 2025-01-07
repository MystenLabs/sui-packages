module 0xa1a37f4e9b0d8927958f1a46805f30f04b8734b7ec944600c92f27e5ffa4fb1b::ziro {
    struct ZIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIRO>(arg0, 6, b"ZIRO", b"Sui Ziro", b"I am Ziro, you are Ziro, we are $ZIRO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000017607_affaac36d3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

