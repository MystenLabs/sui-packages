module 0xf18985d5424b4c32fa6ae9279e184d10ba9d2779561574fc37753af7909a1eba::pear {
    struct PEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEAR>(arg0, 6, b"PEAR", b"Penguin Bear", b"I still can't fly :(", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_512_x_512_px_20_daf9062db4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

