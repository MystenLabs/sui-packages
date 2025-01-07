module 0xd54ad78345612d3427d805dad5b71161afbdff6d2d81366428a9e820b9037412::pmcd {
    struct PMCD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMCD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMCD>(arg0, 6, b"PMCD", b"PENGU MCDONALD", b"PENGU MCDONALD - a great waddler for humanity on Sui !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d_By5y_Tcg_400x400_a17a495000.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMCD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PMCD>>(v1);
    }

    // decompiled from Move bytecode v6
}

