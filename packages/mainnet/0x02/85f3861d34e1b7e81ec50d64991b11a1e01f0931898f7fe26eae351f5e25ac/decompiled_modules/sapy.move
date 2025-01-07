module 0x285f3861d34e1b7e81ec50d64991b11a1e01f0931898f7fe26eae351f5e25ac::sapy {
    struct SAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPY>(arg0, 6, b"SAPY", b"Sapybara", b"Capybara on Sui - Sapybara !!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/We_M6i_S45_400x400_71efb19cee.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

