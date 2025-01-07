module 0xc310f734cc9abfbdfd983a5a22a0fa89058a05758f5b20cc4a6c95c270dbad26::trd {
    struct TRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRD>(arg0, 6, b"TRD", b"Tired", b"No socials so send it! I am so tired of constant rugs and scammers just let me rest", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1528726599670_d959350acf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

