module 0x1345d25ea9aa8c6abcf7bed14920d4c2afbb17c762868d5244d6cc665cf38213::sfn {
    struct SFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFN>(arg0, 9, b"SFN", b"SUIFUN", b"STILNO_AXUENNO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/223a45c62bbf69d68bb6cd2722411d94blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

