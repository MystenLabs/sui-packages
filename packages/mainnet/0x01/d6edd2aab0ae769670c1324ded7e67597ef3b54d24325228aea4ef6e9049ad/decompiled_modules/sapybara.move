module 0x1d6edd2aab0ae769670c1324ded7e67597ef3b54d24325228aea4ef6e9049ad::sapybara {
    struct SAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPYBARA>(arg0, 6, b"SAPYBARA", b"Capybara on Sui", b"Hype enough, xmas gift come", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_M6i_S45_400x400_e2b6ed0e7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPYBARA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPYBARA>>(v1);
    }

    // decompiled from Move bytecode v6
}

