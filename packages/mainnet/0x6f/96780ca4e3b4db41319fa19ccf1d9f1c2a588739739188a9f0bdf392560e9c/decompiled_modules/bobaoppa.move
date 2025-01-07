module 0x6f96780ca4e3b4db41319fa19ccf1d9f1c2a588739739188a9f0bdf392560e9c::bobaoppa {
    struct BOBAOPPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBAOPPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBAOPPA>(arg0, 6, b"BOBAOPPA", b"Boba Oppa", x"4d6163686942696742726f746865727320736f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GJ_2b_AD_Hbc_A_Aj_N_Sr_5c2f784c9a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBAOPPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBAOPPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

