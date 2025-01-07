module 0x2cf365ed1b685a7f8d3f4bd49b216fad9fff56ad4aef6b4aa276c75a6b3f7754::capybara {
    struct CAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA>(arg0, 9, b"CAPYBARA", b"Capybara", b"Link buy in here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9caaec2-e980-4111-9310-519245783057.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

