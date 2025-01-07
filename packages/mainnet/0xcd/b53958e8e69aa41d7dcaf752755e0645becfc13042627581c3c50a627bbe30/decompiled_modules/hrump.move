module 0xcdb53958e8e69aa41d7dcaf752755e0645becfc13042627581c3c50a627bbe30::hrump {
    struct HRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRUMP>(arg0, 6, b"Hrump", b"Hrumpp", b"Hrump is here..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5497_1115b821b1.GIF")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

