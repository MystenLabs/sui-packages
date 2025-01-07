module 0x884d6bf72a7483b4802c779df570c74438bbd1b7ce234b753dca0a5c6231b2c7::marten {
    struct MARTEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARTEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARTEN>(arg0, 6, b"MARTEN", b"SuiMarten", b"SuiMarten the marten dives into the world of Sui Memecoins. Come and join SuiMarten on his adventure in the depths of the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022226_a77d279bfc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARTEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARTEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

