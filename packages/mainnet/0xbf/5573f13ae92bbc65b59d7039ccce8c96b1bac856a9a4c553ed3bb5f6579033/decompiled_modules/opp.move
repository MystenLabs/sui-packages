module 0xbf5573f13ae92bbc65b59d7039ccce8c96b1bac856a9a4c553ed3bb5f6579033::opp {
    struct OPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPP>(arg0, 9, b"OPP", b"7K smarttrading", b"Smarttrading", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f66828ea370d7f2b61460d6c004510ecblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

