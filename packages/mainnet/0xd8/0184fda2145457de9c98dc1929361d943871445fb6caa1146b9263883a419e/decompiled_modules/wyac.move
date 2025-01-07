module 0xd80184fda2145457de9c98dc1929361d943871445fb6caa1146b9263883a419e::wyac {
    struct WYAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYAC>(arg0, 6, b"WYAC", b"WYAC on SUI", b"Official WOMAN YELLING AT CAT Token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wyac_a17774903e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WYAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

