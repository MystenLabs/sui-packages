module 0x5712ad96f7ecb1119cda2ad28b5336f1b7c3993de23f102ff6bc1cca6e38e78c::chick {
    struct CHICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHICK>(arg0, 6, b"CHICK", b"Sui Chick", b"Nature is lovely, Chick is lovelier", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_05_T165214_210_d270ed14cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHICK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHICK>>(v1);
    }

    // decompiled from Move bytecode v6
}

