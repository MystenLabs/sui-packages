module 0xc3ac72f733d7f451292aa6676595aad3c8356fff66af79f8d05a59fdaf7be289::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"SUI CAT", x"466f726765742074686520646f67732e20546865206675747572652069732066656c696e6520e2809420616e642053554920434154206c656164732074686520636861726765207769746820636c617773206f757420616e642061206b61776169692061747469747564652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1752948845956.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

