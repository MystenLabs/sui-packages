module 0x48115367b56d48225a5772cb0bee84bc02151789e4b3ecf3a9c69c57236a4333::cwif {
    struct CWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIF>(arg0, 6, b"CWIF", b"catwifhat", b"The hattest cat on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9v04_Y_Hyb_400x400_77b98af746.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

