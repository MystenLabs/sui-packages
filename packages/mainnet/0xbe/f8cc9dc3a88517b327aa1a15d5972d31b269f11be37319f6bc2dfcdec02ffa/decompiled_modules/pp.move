module 0xbef8cc9dc3a88517b327aa1a15d5972d31b269f11be37319f6bc2dfcdec02ffa::pp {
    struct PP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PP>(arg0, 9, b"PP", b"prawn", b"official coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7f507ef394a0bc769df403fc1be1c297blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

