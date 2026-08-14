module 0x320ceb6d8494d5c741b498e10224a55309bc0f700af162803a70e27e1807d07f::orcawhale {
    struct ORCAWHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORCAWHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORCAWHALE>(arg0, 9, b"ORCA", b"OrcaWhale", b"OrcaWhale Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1786740152094-4ce1f4e935be23f1d09f863ec9e53a12.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<ORCAWHALE>>(0x2::coin::mint<ORCAWHALE>(&mut v2, 21000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORCAWHALE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORCAWHALE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

