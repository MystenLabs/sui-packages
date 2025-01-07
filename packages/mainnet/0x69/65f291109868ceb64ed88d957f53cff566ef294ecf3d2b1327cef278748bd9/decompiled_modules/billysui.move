module 0x6965f291109868ceb64ed88d957f53cff566ef294ecf3d2b1327cef278748bd9::billysui {
    struct BILLYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BILLYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BILLYSUI>(arg0, 6, b"BillySui", b"To Billy", b"Turbos is pioneering a wave a billion dollar tokens on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950555971.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BILLYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BILLYSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

