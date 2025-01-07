module 0xc2e72f7736a4af8c571b22b7dad59b17a2dd4021c72c1046677a34d00d362577::nino {
    struct NINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NINO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NINO>(arg0, 6, b"NINO", b"Sui Nino", b"Nino will be the next mascot of Sui, riding the waves and diving into the beautiful depths of the sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_83_bc379ddecf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NINO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NINO>>(v1);
    }

    // decompiled from Move bytecode v6
}

