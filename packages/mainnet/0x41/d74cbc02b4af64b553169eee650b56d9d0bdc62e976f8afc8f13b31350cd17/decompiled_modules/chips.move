module 0x41d74cbc02b4af64b553169eee650b56d9d0bdc62e976f8afc8f13b31350cd17::chips {
    struct CHIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIPS>(arg0, 6, b"Chips", b"Sui Blue Chip", b"A blue potato mfer stands alone as the sole blue-chip memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dov_952223644e_ac1ab1b387_f16f49992b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

