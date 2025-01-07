module 0x41264ecf299932b79642f311375f859acbe951484cf0ceb1448996bff02ca88::scam7k {
    struct SCAM7K has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAM7K, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAM7K>(arg0, 9, b"SCAM7K", b"7k.fun Scam Platform", x"4920707572636861736564206d656d6520746f6b656e73206f6e20376b2e66756e2c20706169642077697468205355492c20627574206469646ee280997420726563656976652074686520746f6b656e732e204920636f756c646ee28099742066696e6420616e79206f6666696369616c20446973636f7264206f722054656c656772616d2067726f75702e2049206e65656420746f2074616b6520616374696f6ee280945343414d20706c6174666f726d212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/97b1604db048f44d576f54a26474a9e3blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SCAM7K>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAM7K>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

