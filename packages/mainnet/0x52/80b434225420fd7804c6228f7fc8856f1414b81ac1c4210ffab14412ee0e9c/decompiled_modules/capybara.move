module 0x5280b434225420fd7804c6228f7fc8856f1414b81ac1c4210ffab14412ee0e9c::capybara {
    struct CAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA>(arg0, 6, b"CAPYBARA", b"Sui Capybara", b"Capybara is built on network SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/29582124_s_54757cb226.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

