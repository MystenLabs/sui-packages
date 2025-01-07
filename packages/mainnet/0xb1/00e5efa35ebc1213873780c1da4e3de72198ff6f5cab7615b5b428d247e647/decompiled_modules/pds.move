module 0xb100e5efa35ebc1213873780c1da4e3de72198ff6f5cab7615b5b428d247e647::pds {
    struct PDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDS>(arg0, 6, b"PDS", b"PIXEL DUCK SUI", b"Pixel Duck on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/b73f833ab1d1cdf440d3f79be6c6b457_81211650a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

