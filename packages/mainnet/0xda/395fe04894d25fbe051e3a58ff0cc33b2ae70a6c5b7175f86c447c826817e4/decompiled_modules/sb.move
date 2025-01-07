module 0xda395fe04894d25fbe051e3a58ff0cc33b2ae70a6c5b7175f86c447c826817e4::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 9, b"SB", b"Suibase", b"Suibase  , The Gateway to mars by  SuiX Aerospace , Founded by  MYSTEN LABS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b422a07c41fc653b360cbd9f2c5ba729blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

