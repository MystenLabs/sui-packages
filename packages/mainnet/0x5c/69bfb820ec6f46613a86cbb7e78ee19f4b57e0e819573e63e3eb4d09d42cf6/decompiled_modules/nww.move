module 0x5c69bfb820ec6f46613a86cbb7e78ee19f4b57e0e819573e63e3eb4d09d42cf6::nww {
    struct NWW has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWW>(arg0, 6, b"NWW", b"NO WORLD WAR III", b"Join the movement on MOVEPUMP to stop WW III today chads!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wwticker_bac3432d2e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NWW>>(v1);
    }

    // decompiled from Move bytecode v6
}

