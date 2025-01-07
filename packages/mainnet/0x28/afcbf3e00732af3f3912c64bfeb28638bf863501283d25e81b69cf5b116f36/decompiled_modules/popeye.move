module 0x28afcbf3e00732af3f3912c64bfeb28638bf863501283d25e81b69cf5b116f36::popeye {
    struct POPEYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPEYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPEYE>(arg0, 6, b"POPEYE", b"POPEYE ON SUI", b"It's POPEYE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_9926f106f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPEYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPEYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

