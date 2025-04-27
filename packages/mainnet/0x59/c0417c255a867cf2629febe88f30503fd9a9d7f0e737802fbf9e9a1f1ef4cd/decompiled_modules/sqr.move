module 0x59c0417c255a867cf2629febe88f30503fd9a9d7f0e737802fbf9e9a1f1ef4cd::sqr {
    struct SQR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQR>(arg0, 9, b"SQR", b"Squirrel GRANY", b"JUST A Squirrel CHILLING STUDYING SIPPING ON TEA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1b7334b310a1837577c9d48eabca2141blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SQR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

