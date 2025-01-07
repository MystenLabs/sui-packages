module 0x36d8f73cc375029234ba974a86095dbfb99a238f79dda49343b710a48af9e511::suipercycle {
    struct SUIPERCYCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPERCYCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPERCYCLE>(arg0, 6, b"Suipercycle", b"SUIPERCYCLE (real)", b"it's real ! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Votre_texte_de_paragraphe_12_aa1c5a1c8c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPERCYCLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIPERCYCLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

