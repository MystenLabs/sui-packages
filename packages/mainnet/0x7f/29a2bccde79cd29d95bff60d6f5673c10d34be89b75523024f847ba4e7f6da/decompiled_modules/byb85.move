module 0x7f29a2bccde79cd29d95bff60d6f5673c10d34be89b75523024f847ba4e7f6da::byb85 {
    struct BYB85 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYB85, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYB85>(arg0, 9, b"Byb85", b"beyabt85", b"made in beyabt85", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4a228f6034d179f0e8a609bd5f72644dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BYB85>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYB85>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

