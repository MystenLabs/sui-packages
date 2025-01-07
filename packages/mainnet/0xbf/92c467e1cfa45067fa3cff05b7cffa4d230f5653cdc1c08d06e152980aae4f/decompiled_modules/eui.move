module 0xbf92c467e1cfa45067fa3cff05b7cffa4d230f5653cdc1c08d06e152980aae4f::eui {
    struct EUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EUI>(arg0, 6, b"EUI", b"EUI SUI", b"$EUI dola on sui oh fuck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_19_34_02_10e1bb66e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

