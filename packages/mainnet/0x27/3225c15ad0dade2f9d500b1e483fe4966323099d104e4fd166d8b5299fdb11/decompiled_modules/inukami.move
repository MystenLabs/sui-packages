module 0x273225c15ad0dade2f9d500b1e483fe4966323099d104e4fd166d8b5299fdb11::inukami {
    struct INUKAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: INUKAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INUKAMI>(arg0, 6, b"INUKAMI", b"INUKAMI ON SUI", b"Dexscreener paid:https://inukamionsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2_9_7d612f4f9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INUKAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INUKAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

