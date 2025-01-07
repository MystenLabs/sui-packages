module 0xbe400edc25cb60ffc1a3af0b9f851859742042b94012c193b98c2016f693cf50::goatwf {
    struct GOATWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOATWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOATWF>(arg0, 6, b"GOATWF", b"GOAT WIF HAT", b"We are goats, that wear a hat, on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_11_28_at_10_22_19a_pm_af18f46757.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOATWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOATWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

