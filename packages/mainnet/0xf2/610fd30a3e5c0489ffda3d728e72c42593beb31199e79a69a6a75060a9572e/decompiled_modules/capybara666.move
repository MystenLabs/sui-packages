module 0xf2610fd30a3e5c0489ffda3d728e72c42593beb31199e79a69a6a75060a9572e::capybara666 {
    struct CAPYBARA666 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA666, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA666>(arg0, 6, b"Capybara666", b"Capybara", b"Capybara bless for u! Good luck!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4957a410810e_d9b9465c61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA666>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYBARA666>>(v1);
    }

    // decompiled from Move bytecode v6
}

