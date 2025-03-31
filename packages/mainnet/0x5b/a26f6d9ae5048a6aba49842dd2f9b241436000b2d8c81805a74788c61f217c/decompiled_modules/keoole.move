module 0x5ba26f6d9ae5048a6aba49842dd2f9b241436000b2d8c81805a74788c61f217c::keoole {
    struct KEOOLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEOOLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEOOLE>(arg0, 9, b"Keoole", b"beede", b"dgeree", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/cd428b22672472efe127ca88a8b8f31bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KEOOLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEOOLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

