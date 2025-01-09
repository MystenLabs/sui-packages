module 0x48ea79581f1d0465160da5e21cf1244753956bc99a4ba293540f7d6542169969::oiiaoiia {
    struct OIIAOIIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OIIAOIIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OIIAOIIA>(arg0, 6, b"OIIAOIIA", b"Oo Ee AEA Cat", b"A  Spinning Cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/oiia1_2f151aa366.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OIIAOIIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OIIAOIIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

