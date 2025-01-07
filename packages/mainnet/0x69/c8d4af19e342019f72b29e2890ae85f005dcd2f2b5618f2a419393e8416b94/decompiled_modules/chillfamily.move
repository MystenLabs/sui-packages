module 0x69c8d4af19e342019f72b29e2890ae85f005dcd2f2b5618f2a419393e8416b94::chillfamily {
    struct CHILLFAMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLFAMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLFAMILY>(arg0, 6, b"CHILLFAMILY", b"just a CHILLFAMILY", b"Just a CHILLFAMILY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chill_family_b8b6c04c6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFAMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLFAMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

