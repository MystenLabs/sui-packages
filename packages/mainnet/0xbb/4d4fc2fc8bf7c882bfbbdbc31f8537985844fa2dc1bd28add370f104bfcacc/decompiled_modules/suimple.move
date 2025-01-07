module 0xbb4d4fc2fc8bf7c882bfbbdbc31f8537985844fa2dc1bd28add370f104bfcacc::suimple {
    struct SUIMPLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMPLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMPLE>(arg0, 6, b"SUIMPLE", b"Suimple", b"Everything Suimple. No TG. No Socials. No Website. Only Dex Payment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suimple_PFP_37f4365051.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMPLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMPLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

