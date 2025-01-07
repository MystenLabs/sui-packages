module 0xb55c6d142fbeaf23944afb5055173e2dccc60e72e0bd839ecd8fd5b1d7e700ad::bbsui {
    struct BBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUI>(arg0, 6, b"BBSUI", b"Boc Boc Sui", b"Boc Boc Boc Boc Boc ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bocboc_df7f685b1c.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

