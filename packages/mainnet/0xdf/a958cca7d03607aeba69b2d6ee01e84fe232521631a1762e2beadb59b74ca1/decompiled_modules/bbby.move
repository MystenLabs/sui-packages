module 0xdfa958cca7d03607aeba69b2d6ee01e84fe232521631a1762e2beadb59b74ca1::bbby {
    struct BBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBBY>(arg0, 6, b"BBBY", b"Bed Bath & Beyond", b"Keeping the memory of the legendary memestock and liquidated retail giant, Bed Bath & Beyond, alive. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5333_351cd899ae.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

