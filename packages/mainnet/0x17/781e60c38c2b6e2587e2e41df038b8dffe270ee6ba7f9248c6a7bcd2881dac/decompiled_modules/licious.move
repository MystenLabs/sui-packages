module 0x17781e60c38c2b6e2587e2e41df038b8dffe270ee6ba7f9248c6a7bcd2881dac::licious {
    struct LICIOUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LICIOUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LICIOUS>(arg0, 6, b"Licious", b"SUIlicious", x"5355692069732064656c6963696f75730a50726f66697473206172652064656c6963696f75730a436f6d6d756e6974792069732064656c6963696f75730a45766572797468696e672070726563696f7573206973205355496c6963696f7573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241006_084839_235c4dd7ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LICIOUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LICIOUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

