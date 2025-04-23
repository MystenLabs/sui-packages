module 0xd4431507a5e3b12ea6dbd6a7f94641dc42759e8665f72d967bddbb8982756cf5::fbtc {
    struct FBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FBTC>(arg0, 9, b"FBTC", b"FAKE BTC", b"THIS COIN IS FAKE BITCOIN & I AM THE FAKE SATOSHI NAKAMOTU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5dee4c82b3fad85faadec8945797a80fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

