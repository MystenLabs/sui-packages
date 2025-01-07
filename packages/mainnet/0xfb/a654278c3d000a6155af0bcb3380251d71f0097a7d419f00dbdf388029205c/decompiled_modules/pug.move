module 0xfba654278c3d000a6155af0bcb3380251d71f0097a7d419f00dbdf388029205c::pug {
    struct PUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUG>(arg0, 6, b"PUG", b"first bitcoin pug", x"54686520666972737420646f67207265676973746572656420696e20626974636f696e20626c6f636b636861696e2e0a0a54686520507567205361746f736869200a426f726e3a2030392d4155472d323031360a414b4320526567697374726174696f6e3a20545333313330343030320a4d6963726f636869703a20374531303038343732310a424c4f434b3a20343332393431", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZE_9_I_Ze_WQAAJG_Wk_8ce9b7ae7a.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

