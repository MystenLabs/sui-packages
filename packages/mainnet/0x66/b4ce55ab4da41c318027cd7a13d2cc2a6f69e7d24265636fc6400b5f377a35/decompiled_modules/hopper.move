module 0x66b4ce55ab4da41c318027cd7a13d2cc2a6f69e7d24265636fc6400b5f377a35::hopper {
    struct HOPPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPPER>(arg0, 6, b"HOPPER", b"SuiHopper", b"New hopper on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000948_c619b1b07e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

