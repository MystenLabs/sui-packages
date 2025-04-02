module 0x124e6d4a80795d2a3739c0291609a24a75dd5ad3936e0306274dd6cca967a6cf::bzk {
    struct BZK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZK>(arg0, 9, b"Bzk", b"bulkz Tomford watch", b"this is for all lovers of luxury", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b93604f34417f4714973b0d8a964965bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BZK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

