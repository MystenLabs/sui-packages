module 0x1b8fbb3a1aabe688f48987b54bd0c7ec80101ecf86bd8b252498ea059199994e::stama {
    struct STAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAMA>(arg0, 6, b"STAMA", b"SUITAMA", b"SUI needs a hero and $STAMA is the guy for the job!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/E_1ia_N7n_400x400_dbee43aa7e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

