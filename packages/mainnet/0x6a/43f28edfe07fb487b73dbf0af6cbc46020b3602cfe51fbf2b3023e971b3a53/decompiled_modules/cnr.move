module 0x6a43f28edfe07fb487b73dbf0af6cbc46020b3602cfe51fbf2b3023e971b3a53::cnr {
    struct CNR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNR>(arg0, 6, b"CNR", b"Canary", x"43616e617279206f6e20737569200a0a796f752063616e2073696e672077697468206d6520202e2e2e2e2e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001830_aaf52b2442.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CNR>>(v1);
    }

    // decompiled from Move bytecode v6
}

