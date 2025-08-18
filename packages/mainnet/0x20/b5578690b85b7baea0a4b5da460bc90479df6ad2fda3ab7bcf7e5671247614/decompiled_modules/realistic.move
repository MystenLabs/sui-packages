module 0x20b5578690b85b7baea0a4b5da460bc90479df6ad2fda3ab7bcf7e5671247614::realistic {
    struct REALISTIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: REALISTIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REALISTIC>(arg0, 9, b"Realistic", b"Realistic", b"Not Manifest, but Realistic.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<REALISTIC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REALISTIC>>(v2, @0x916428291a4bbca8066cdb87a7882c95ce1510399df1cf6c6c23ea5de3a7957);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REALISTIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

