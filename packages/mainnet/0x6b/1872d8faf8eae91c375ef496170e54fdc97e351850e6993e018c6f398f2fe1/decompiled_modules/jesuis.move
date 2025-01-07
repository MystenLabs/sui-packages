module 0x6b1872d8faf8eae91c375ef496170e54fdc97e351850e6993e018c6f398f2fe1::jesuis {
    struct JESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: JESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JESUIS>(arg0, 6, b"Jesuis", b"Jesuis Sui", b"Amem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Imagem_do_Whats_App_de_2024_10_13_A_s_22_16_17_1b4bf644_4b4dcb9284.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JESUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

