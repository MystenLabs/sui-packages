module 0x32b3173a2833fc8a55f2cf9d7457b5ee47af6a2029daa64c0dbe6a23b4927bc7::stackdrow {
    struct STACKDROW has drop {
        dummy_field: bool,
    }

    fun init(arg0: STACKDROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STACKDROW>(arg0, 6, b"STACKDROW", b"stackdrow Coin", b"Official stackdrow coin on sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008647_9327a4b899.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STACKDROW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STACKDROW>>(v1);
    }

    // decompiled from Move bytecode v6
}

