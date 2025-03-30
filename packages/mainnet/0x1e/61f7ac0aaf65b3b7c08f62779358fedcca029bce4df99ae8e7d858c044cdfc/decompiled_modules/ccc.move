module 0x1e61f7ac0aaf65b3b7c08f62779358fedcca029bce4df99ae8e7d858c044cdfc::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 9, b"CCC", b"CuantiC COIN", x"546865206e6578742067656e65726174696f6e2020636f696e2e200a5472757374207468652070726f6365737321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9335fd6341e28479dc97ff0c53e78cefblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

