module 0x6a7e88d201ddcd60310740b87dd8e6cc9d70590e6e8204f1d6841eedf99de119::ffloki {
    struct FFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FFLOKI>(arg0, 6, b"FFLOKI", b"FireFloki", b"Fire Floki is FLOKI on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014452_db142eaae3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FFLOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FFLOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

