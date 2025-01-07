module 0x5b073b4d5d5ec9871690bf200ea1d80e43b70c788e46e55ac0de4a57e54e29ac::ge {
    struct GE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GE>(arg0, 9, b"GE", b"GOLDEN EGG", x"476f6f6420696e766573746d656e7420696e20676f6c64656e20656767200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e8b0131edefe62845b36adfb23b1c271blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

