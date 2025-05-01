module 0x1bc37d1793d7a6008f8f0103c02daa50ce0022e27b1afb8d932cc1f3c9ba8b31::ebisui {
    struct EBISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EBISUI>(arg0, 6, b"EBISUI", b"Ebisui", b"Cast your net with patience and effort for true fortune favors those who honor the work before the reward https://ebisuitoken.com ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_SD_Uchun_400x400_2e3fe1c5d8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EBISUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EBISUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

