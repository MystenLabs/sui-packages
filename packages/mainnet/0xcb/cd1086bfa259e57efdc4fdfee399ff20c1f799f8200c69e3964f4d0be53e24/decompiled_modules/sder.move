module 0xcbcd1086bfa259e57efdc4fdfee399ff20c1f799f8200c69e3964f4d0be53e24::sder {
    struct SDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDER>(arg0, 6, b"Sder", b"Suinder", x"54686520666972737420646174696e6720617070206f6e207468652024737569206e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suider_91f9f89f63.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDER>>(v1);
    }

    // decompiled from Move bytecode v6
}

