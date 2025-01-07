module 0x19cb009f0bcaf855f83b4a668a49b4703326e38e714752554d993db64c02530d::rizzo {
    struct RIZZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIZZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIZZO>(arg0, 6, b"RIZZO", b"Rizzo the Rat", b"Rizzo the Rat and Pepe the King Prawn are both characters from the \"Muppets\" franchise, known for their comedic roles and interactions, especially in movies like \"Muppets from Space\" and various Muppet television shows.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/J8xopmtpj5s_Lgh_Sugc_QGZ_Tn_Rw_GHBG_Nq_C2ivgeh_Nxpump_e33154c642.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIZZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIZZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

