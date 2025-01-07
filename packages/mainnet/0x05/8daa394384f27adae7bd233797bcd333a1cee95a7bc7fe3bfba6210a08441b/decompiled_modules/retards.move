module 0x58daa394384f27adae7bd233797bcd333a1cee95a7bc7fe3bfba6210a08441b::retards {
    struct RETARDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: RETARDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RETARDS>(arg0, 6, b"RETARDS", b"SUI TRADER (S-TRADER)", b"SUI RETARDS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_E8_O_Ae_N_460s_73f26b10cb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RETARDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RETARDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

