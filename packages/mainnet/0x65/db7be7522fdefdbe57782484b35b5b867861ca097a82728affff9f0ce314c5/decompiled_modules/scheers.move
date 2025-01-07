module 0x65db7be7522fdefdbe57782484b35b5b867861ca097a82728affff9f0ce314c5::scheers {
    struct SCHEERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCHEERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCHEERS>(arg0, 6, b"SCHEERS", b"Sparrow Cheers", b"If you were waiting for the opportune moment, that was it (jack sparrow)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5928_12525bdbaf.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCHEERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCHEERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

