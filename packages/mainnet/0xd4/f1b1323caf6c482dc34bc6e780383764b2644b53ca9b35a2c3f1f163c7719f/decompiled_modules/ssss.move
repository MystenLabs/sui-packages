module 0xd4f1b1323caf6c482dc34bc6e780383764b2644b53ca9b35a2c3f1f163c7719f::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSS>(arg0, 6, b"SSSS", b"dd", b"dfdsfsdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihpgra6yzmpabtcexbgwphtghf2oekcfwamlhdvxuiacczqyn7xg4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SSSS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

