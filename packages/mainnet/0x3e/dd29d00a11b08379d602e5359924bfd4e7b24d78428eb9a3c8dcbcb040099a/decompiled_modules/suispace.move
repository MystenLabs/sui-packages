module 0x3edd29d00a11b08379d602e5359924bfd4e7b24d78428eb9a3c8dcbcb040099a::suispace {
    struct SUISPACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISPACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISPACE>(arg0, 9, b"SUISPACE", b"SUI Space", b" ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/02fb703c8012ea7f0f97ddea377bc9a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISPACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISPACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

