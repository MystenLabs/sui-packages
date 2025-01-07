module 0xbee5564ee3fb6fd9c661090c94a23e901de1a9660690d33651aa71341268bee2::momo {
    struct MOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMO>(arg0, 6, b"MOMO", b"MOMOSUI", b"Momo degen mummy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000133726_0b494beff4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

