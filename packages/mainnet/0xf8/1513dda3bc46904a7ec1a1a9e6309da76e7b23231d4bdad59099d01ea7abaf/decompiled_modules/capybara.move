module 0xf81513dda3bc46904a7ec1a1a9e6309da76e7b23231d4bdad59099d01ea7abaf::capybara {
    struct CAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA>(arg0, 6, b"CAPYBARA", b"Capybara", b"Capybaraa on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7d36d304_c16f_48ce_9917_ee301ab7bdd1_bf1d7e380f_4a115f9c82.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

