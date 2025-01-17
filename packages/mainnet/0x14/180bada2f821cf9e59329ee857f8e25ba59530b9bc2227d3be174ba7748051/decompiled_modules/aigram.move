module 0x14180bada2f821cf9e59329ee857f8e25ba59530b9bc2227d3be174ba7748051::aigram {
    struct AIGRAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIGRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIGRAM>(arg0, 9, b"AIGRAM", b"Telegram Engine", x"596f757220756c74696d6174652068656c70657220696e20636f6c6c656374696e67206461746120616e6420696e666f726d6174696f6e2e200a48656c707320796f752066696e642073706563696669632074656c656772616d2067726f7570732026206368616e6e656c732077697468207468652068656c70206f66204172746966696369616c20496e74656c6c6967656e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmURiywfS21DdiPf3Gg5v9FTLFRfpKVF149jzUEyQzfmyb")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AIGRAM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIGRAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIGRAM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

