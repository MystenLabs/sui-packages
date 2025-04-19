module 0x4f12daa810395ca292a07ac647c0afb7d29a681df05ea85382eed3f6f38933f6::abs {
    struct ABS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABS>(arg0, 9, b"ABS", b"7KABS", b"7 abstract universe descentralized", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/469489cafd89304d7c024258fe3324afblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ABS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

