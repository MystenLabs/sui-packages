module 0x84926b836adce79c7df23cdcc08db13198eb14704dc39d96b5fde2dec0108658::savior {
    struct SAVIOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAVIOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAVIOR>(arg0, 6, b"SAVIOR", b"OFFICIAL SAVIOR SUI", b"The savior of our bags, the one and only Donald Trump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_043955_396_fa15463aaa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAVIOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAVIOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

