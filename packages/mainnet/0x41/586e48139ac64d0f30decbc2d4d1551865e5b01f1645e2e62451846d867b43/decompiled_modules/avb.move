module 0x41586e48139ac64d0f30decbc2d4d1551865e5b01f1645e2e62451846d867b43::avb {
    struct AVB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVB>(arg0, 9, b"AVB", b"avb1001", b"NEW HERO IN THE WORLD 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b53cb9d1d56fe50b3fc0a8636071255dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

