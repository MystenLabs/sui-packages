module 0x7f4d2501d45489c85351bff4ab7e6f7899fdfbb2189786f962f9928e54ed6e26::puggy {
    struct PUGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGGY>(arg0, 6, b"PUGGY", b"Puggydog", x"5055474759444f4720697320746865206d6f737420636f6f6c65737420616e64206472697070696e272064617767206f6e0a5375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeidpcv2qcwehyf25oemnm47mvkrpsvymmna7r2n45fu2js6shqqwqq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGGY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUGGY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

