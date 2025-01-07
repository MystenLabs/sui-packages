module 0x12235834c9410b12cbc855f0dd0f80ced8e642a3fb210d70b2230cb5c2186a33::capybara {
    struct CAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA>(arg0, 6, b"Capybara", b"capybara", b"Capybara bless u!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4957a410810e_515d9c93d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

