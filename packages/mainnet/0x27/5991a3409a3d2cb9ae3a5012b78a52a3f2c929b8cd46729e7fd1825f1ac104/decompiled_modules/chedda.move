module 0x275991a3409a3d2cb9ae3a5012b78a52a3f2c929b8cd46729e7fd1825f1ac104::chedda {
    struct CHEDDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHEDDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHEDDA>(arg0, 6, b"Chedda", b"Chedda on Sui", x"24636865646461206c6f6f6b696e6720746f206d616b65206c697665732062657474610a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chedda_logo_icon_01_480x480_01bba5beae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHEDDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHEDDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

