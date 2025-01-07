module 0x11d5de593bb5eb15be4d9f329fdb2167d64dea60dfe53601ac20acf6c7cecd1d::sovia {
    struct SOVIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOVIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOVIA>(arg0, 6, b"SOVIA", b"Sovia Cutest On SUI", x"496620796f7527726520646f6e27742068617665206769726c667269656e6420627579207468697320746f6b656e20616e642073656e64207468697320746f20746865206d6f6f6ef09f9a802c2067657420726963682077697468207468697320746f6b656e20616e6420796f752772652063616e65206d616b65206c6f7665207769746820616e79206769726ce29da4efb88fe2808df09fa9b9", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734894999605.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOVIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOVIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

