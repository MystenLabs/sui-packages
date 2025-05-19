module 0x38ab779bc1395c55642adb9bf9ca2f34f58fb5110551a3bc9675b03ed9fd22ca::suichi {
    struct SUICHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHI>(arg0, 6, b"SUICHI", b"Suichi Pokemon", b"SUICHI will grant wishes for diamond hands on SUI. No roadmap, no promises, hold SUICHI and your wishes will come true.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieizxy2ccfle7ksu4kxy2zhuz7t576l3edl3ymqy2ddjefx2via6e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUICHI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

