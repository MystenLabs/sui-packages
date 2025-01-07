module 0x3b5fbe1c1b6c147d0adf7606c1044b8babe79f42dd2e6fcb301823f50df6bc83::the {
    struct THE has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE>(arg0, 9, b"THE", b"THENA", b"thena", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/01cdc6686d84020ecce2f0b46376c4cdblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<THE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

