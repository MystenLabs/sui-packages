module 0x5227644de2324bbda62072c935601ff5ad80dee116a2c784655d4122fcd0d00e::gege {
    struct GEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEGE>(arg0, 6, b"GEGE", b"SUI GEGE", b"GEGE isnt just any character out of a book. Hes way more than that. He's the ultimate icon everyone dreams of becoming and the next mascot of SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Karya_Seni_Tanpa_Judul_51_e660e99621.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

