module 0x257ce39739e0593ef2c217f0cce50f5ed0d79338bbe6c5a583f1701ece2cb87::sube {
    struct SUBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUBE>(arg0, 6, b"SUBE", b"Suibee", x"46697273742062656572206f6e207375690a436f6d65207269646520776974682075732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20240619_131732_513_23e755e386.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

