module 0x1d58af292110fcb1e1de130c7d53e9b0d09d8ff0e3a64be10563bdb73e1ee10a::jfish {
    struct JFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFISH>(arg0, 6, b"JFISH", b"$JELLYFISH ON SUI", b"JELLYFISH ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_ae_e322633f99.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

