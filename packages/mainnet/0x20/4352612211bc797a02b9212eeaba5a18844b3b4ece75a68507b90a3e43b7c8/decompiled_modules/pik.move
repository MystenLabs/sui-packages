module 0x204352612211bc797a02b9212eeaba5a18844b3b4ece75a68507b90a3e43b7c8::pik {
    struct PIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIK>(arg0, 9, b"PIK", b"pikachu", b"Magic flying saucer, bringing magic to the sui ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f466487d94ce2d59e38caf8bacc2ad67blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

