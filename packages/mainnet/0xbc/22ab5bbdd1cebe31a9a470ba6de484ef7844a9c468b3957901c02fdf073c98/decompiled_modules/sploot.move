module 0xbc22ab5bbdd1cebe31a9a470ba6de484ef7844a9c468b3957901c02fdf073c98::sploot {
    struct SPLOOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLOOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPLOOT>(arg0, 6, b"Sploot", b"SplootSui", b"Lie flat, rise fast.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_070932340_f580642fd9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLOOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPLOOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

