module 0xa47fd846104ba0d4b1deeea0c8afa41ae78ba65a1a4a6b528fe9d45b125cf8b2::babypepe {
    struct BABYPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYPEPE>(arg0, 6, b"Babypepe", b"babypepe", x"4261627970652069732061205065706520626162792c0a426f726e20746f207265706c61636520506570652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Q_Qae_e_a_ae_a_20250102213510_ef3ffb52a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

