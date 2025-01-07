module 0x4043d335d2f5f01eb700d0128daea7a4bf8dbcbc7dd9b15349f74a000cee0eca::mao {
    struct MAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAO>(arg0, 6, b"MAO", b"Maosui", b"Maoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1730748388_704848_5_CB_6870_C_ECE_5_4_DD_8_B4_AE_46_DD_4_C0_DF_186_6761ff37de.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

