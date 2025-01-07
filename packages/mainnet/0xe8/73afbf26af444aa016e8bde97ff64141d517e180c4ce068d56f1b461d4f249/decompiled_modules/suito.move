module 0xe873afbf26af444aa016e8bde97ff64141d517e180c4ce068d56f1b461d4f249::suito {
    struct SUITO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITO>(arg0, 6, b"SUITO", b"SUITOSHI", b"satoshi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_04_17_57_58_0e50663b3b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITO>>(v1);
    }

    // decompiled from Move bytecode v6
}

