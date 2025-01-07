module 0x90894504f318a4dc74a45d0628a9317c7fc6746452e494a3427047547d82d5a9::humu {
    struct HUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUMU>(arg0, 6, b"Humu", b"Humu the Fish", b"The reef triggerfish, also known by its Hawaiian name humuhumunukunukupuaa (meaning 'triggerfish with a snout like a pig).", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_25_09_40_50_b4e4d1fcec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

