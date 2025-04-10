module 0xe31a7732768b84d2068c19a3c18bc5cc534dcc85c265903f084a3be0f405a2f7::drp {
    struct DRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRP>(arg0, 9, b"Drp", b"Drop", b"Drop coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/51a1e2e3c02e04f3d3e4b1f3ced6a336blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

