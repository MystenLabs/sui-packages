module 0x2a1c802f60c68b83440c242bdb159479eb9a5ed8f39cf20438dade6dd745016b::suiseeks {
    struct SUISEEKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEEKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEEKS>(arg0, 6, b"SUISEEKS", b"Mr Suiseeks", b"Look at me!\" and \"I'm Mr. Suiseeks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_Suiseeks_3309f38b15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEEKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEEKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

