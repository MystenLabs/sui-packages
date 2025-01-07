module 0x1fb341aee3c3c05b50616f591ce8407ca92114aff9ccf003d7b2219fae9b887d::capybara666 {
    struct CAPYBARA666 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA666>(arg0, 6, b"Capybara666", b"Capybara", b"Capybara bless u!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4957a410810e_515d9c93d9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYBARA666>>(v1);
    }

    // decompiled from Move bytecode v6
}

