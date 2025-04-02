module 0x542554a011d28ce29e9adbf4c6671c6a211d6b96f88dbf0abc3508230b9cb8ae::mdk {
    struct MDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: MDK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MDK>(arg0, 9, b"MDK", b"Mondok", b"Monad X Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c72e215bece956a3bdaf258f09b8bdeeblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MDK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MDK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

