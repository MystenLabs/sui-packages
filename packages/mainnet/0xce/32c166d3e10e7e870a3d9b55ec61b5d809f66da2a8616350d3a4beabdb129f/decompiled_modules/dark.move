module 0xce32c166d3e10e7e870a3d9b55ec61b5d809f66da2a8616350d3a4beabdb129f::dark {
    struct DARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DARK>(arg0, 6, b"DARK", b"DARKYSUI", b"he holding the pumpkins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Desain_tanpa_judul_9_593938e4dd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

