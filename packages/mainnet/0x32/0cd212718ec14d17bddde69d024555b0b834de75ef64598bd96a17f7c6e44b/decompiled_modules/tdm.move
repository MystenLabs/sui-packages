module 0x320cd212718ec14d17bddde69d024555b0b834de75ef64598bd96a17f7c6e44b::tdm {
    struct TDM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDM>(arg0, 6, b"TDM", b"Donaldus Trumpianus Maximus", b"Socials coming soon!Buy and enjoy the raid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008648_30fdcfbbe2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDM>>(v1);
    }

    // decompiled from Move bytecode v6
}

