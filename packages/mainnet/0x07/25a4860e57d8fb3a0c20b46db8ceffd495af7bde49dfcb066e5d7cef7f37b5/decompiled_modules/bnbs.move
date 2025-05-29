module 0x725a4860e57d8fb3a0c20b46db8ceffd495af7bde49dfcb066e5d7cef7f37b5::bnbs {
    struct BNBS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNBS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNBS>(arg0, 9, b"BNBS", b"BNB SUI", b"Bnb sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/6d378796270ebeaf486baa6473ca451bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNBS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNBS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

