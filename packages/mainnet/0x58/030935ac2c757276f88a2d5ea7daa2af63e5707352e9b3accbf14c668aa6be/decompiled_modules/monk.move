module 0x58030935ac2c757276f88a2d5ea7daa2af63e5707352e9b3accbf14c668aa6be::monk {
    struct MONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONK>(arg0, 6, b"MONK", b"MONK ON SUI", b"$MONK the spooky fish from Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_05_22_21_18_50186040bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONK>>(v1);
    }

    // decompiled from Move bytecode v6
}

