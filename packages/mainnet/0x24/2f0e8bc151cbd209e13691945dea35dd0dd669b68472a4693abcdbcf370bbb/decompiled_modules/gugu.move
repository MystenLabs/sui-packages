module 0x242f0e8bc151cbd209e13691945dea35dd0dd669b68472a4693abcdbcf370bbb::gugu {
    struct GUGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUGU>(arg0, 6, b"GUGU", b"Sui Gugu", b"Gugu has arrived from planet Gaga to search for water on Earth, and hes thrilled to see the waves!  Excited to dive in, Gugu can't wait to swim in the beautiful waters of Sui. Get ready for some intergalactic fun in the ocean! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_92_c6e4d516bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

