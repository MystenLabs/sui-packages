module 0x15f0a4c7b9aaa262120f1890b5882beb0a6d24c70793b21e4408af096f8149ac::squish {
    struct SQUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUISH>(arg0, 6, b"Squish", b"Squish Sui", b"The most Inky Octo-pal, Squishy, squishy, Sui's new buddy. Your eight-armed guide to the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_04_17_48_41_018a986fd6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

