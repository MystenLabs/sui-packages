module 0x1d79440ed8d224fa26d87c3fa9b924ab591bc934d0a486702c8453cfb4ed8326::drw {
    struct DRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRW>(arg0, 9, b"DRW", b"Draw", b"kill token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d8fb47c1a56f1fb32b27c1b5adfe4feeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

