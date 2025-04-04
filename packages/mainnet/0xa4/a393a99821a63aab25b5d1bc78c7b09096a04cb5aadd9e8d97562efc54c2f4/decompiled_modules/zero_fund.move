module 0xa4a393a99821a63aab25b5d1bc78c7b09096a04cb5aadd9e8d97562efc54c2f4::zero_fund {
    struct ZERO_FUND has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZERO_FUND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZERO_FUND>(arg0, 9, b"ZERO_FUND", b"ZFUND", b"ZhFUND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a01cb6a698eb9536581fe2cdb908c22eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZERO_FUND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZERO_FUND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

