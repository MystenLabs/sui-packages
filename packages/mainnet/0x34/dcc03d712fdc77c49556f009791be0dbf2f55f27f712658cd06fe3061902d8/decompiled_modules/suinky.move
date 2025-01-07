module 0x34dcc03d712fdc77c49556f009791be0dbf2f55f27f712658cd06fe3061902d8::suinky {
    struct SUINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINKY>(arg0, 6, b"SUINKY", b"Suinky", b"Hey there! I'm Suiky, a cuddly ball of fluff from the suimoon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_53_fc88692eae.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

