module 0x3453b2f76e643aa5d1085597c726e5722a682901e402f5508712e3fa93afd663::sb {
    struct SB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SB>(arg0, 9, b"SB", b"SuiBro", b"trust me bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c465667bcbfba06478f0be138351d8e8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

