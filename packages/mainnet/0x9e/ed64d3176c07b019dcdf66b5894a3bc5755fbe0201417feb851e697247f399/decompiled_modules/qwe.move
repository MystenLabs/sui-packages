module 0x9eed64d3176c07b019dcdf66b5894a3bc5755fbe0201417feb851e697247f399::qwe {
    struct QWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: QWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QWE>(arg0, 9, b"QWE", b"QWE", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QWE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QWE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_coin(arg0: &mut 0x2::coin::TreasuryCap<QWE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<QWE>>(0x2::coin::mint<QWE>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

