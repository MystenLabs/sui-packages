module 0x4c2e92829db6609c5da0bd5c9ab704d04d00afc9e8c7e5306c62331526c3f12b::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 6, b"Degen", b"Degen Apes", b"just Degens trying to ape... No emotions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Degen_Apes_5906b7822c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

