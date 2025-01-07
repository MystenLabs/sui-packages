module 0xc7f4d45656bc2db304bc7f5414e48fbaa2ce394c8d77b04f2579a79b6d540232::trogdor {
    struct TROGDOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROGDOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROGDOR>(arg0, 6, b"TROGDOR", b"trog dor", b"https://x.com/b1ackd0g/status/1790079345018462286?s=46", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_e9fefa7440.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROGDOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TROGDOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

