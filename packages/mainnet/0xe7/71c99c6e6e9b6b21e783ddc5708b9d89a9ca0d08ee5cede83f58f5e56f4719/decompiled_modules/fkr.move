module 0xe771c99c6e6e9b6b21e783ddc5708b9d89a9ca0d08ee5cede83f58f5e56f4719::fkr {
    struct FKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKR>(arg0, 9, b"FKr", b"fast killer", b"Don't miss this coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f2e05cf8dfd3277bf8de0ea07b0b7909blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FKR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

