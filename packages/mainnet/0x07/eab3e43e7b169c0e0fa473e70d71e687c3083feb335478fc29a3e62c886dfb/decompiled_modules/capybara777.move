module 0x7eab3e43e7b169c0e0fa473e70d71e687c3083feb335478fc29a3e62c886dfb::capybara777 {
    struct CAPYBARA777 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA777, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA777>(arg0, 6, b"Capybara777", b"Capybara", b"Capybara bless for u! Good luck!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4957a410810e_d9b9465c61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA777>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYBARA777>>(v1);
    }

    // decompiled from Move bytecode v6
}

