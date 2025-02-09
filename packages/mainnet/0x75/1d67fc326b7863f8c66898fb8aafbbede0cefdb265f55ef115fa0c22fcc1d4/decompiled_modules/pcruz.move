module 0x751d67fc326b7863f8c66898fb8aafbbede0cefdb265f55ef115fa0c22fcc1d4::pcruz {
    struct PCRUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PCRUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PCRUZ>(arg0, 6, b"Pcruz", b"PuntoDecruZNft", x"50756e746f44656372755a4e667420657320756e204e4654206578636c757369766f20646973706f6e69626c6520656e2043727970746f2e636f6d2c2064697365c3b161646f20706172612061706f7961722061206c6f732074616c656e746f736f73206172746573616e6f7320656e206c6120637265616369c3b36e20646520737573206f62726173206465206172746520656e2074656c612e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739073261168.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PCRUZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PCRUZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

