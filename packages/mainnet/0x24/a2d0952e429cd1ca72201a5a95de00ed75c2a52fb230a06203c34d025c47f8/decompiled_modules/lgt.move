module 0x24a2d0952e429cd1ca72201a5a95de00ed75c2a52fb230a06203c34d025c47f8::lgt {
    struct LGT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LGT>(arg0, 9, b"LGT", b"lightning", b"lightning lightning lightning!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d63d0f8750b489d4656dbd368d6b7a21blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LGT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

