module 0xf90cae7a11a3d877e3bfa83ea086fcaac6156055be08a5d4bba7e10fc4443de6::nonoe {
    struct NONOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NONOE>(arg0, 9, b"NONOE", b"NORE NORE", x"484cc59e49c59e2e2e2e2e554c4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/544628ad72d88421d5cd05daa39c67b1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NONOE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONOE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

