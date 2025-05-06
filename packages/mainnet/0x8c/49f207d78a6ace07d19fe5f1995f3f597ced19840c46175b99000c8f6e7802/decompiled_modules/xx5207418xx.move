module 0x8c49f207d78a6ace07d19fe5f1995f3f597ced19840c46175b99000c8f6e7802::xx5207418xx {
    struct XX5207418XX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XX5207418XX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XX5207418XX>(arg0, 6, b"Xx5207418xX", b"5207418", b"5207418 is the real-life cheat code for unexpected money...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/money_aab1d7c557.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XX5207418XX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XX5207418XX>>(v1);
    }

    // decompiled from Move bytecode v6
}

