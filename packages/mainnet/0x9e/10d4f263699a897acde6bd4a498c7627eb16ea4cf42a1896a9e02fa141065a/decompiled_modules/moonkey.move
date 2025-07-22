module 0x9e10d4f263699a897acde6bd4a498c7627eb16ea4cf42a1896a9e02fa141065a::moonkey {
    struct MOONKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONKEY>(arg0, 6, b"MOONKEY", b"SUIMOONKEY", b"MOONKEY OF SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihc7n524k35shkkngm5eq7mx7nx4yc6xl3ts45q6dyvhalpdpjfty")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONKEY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

