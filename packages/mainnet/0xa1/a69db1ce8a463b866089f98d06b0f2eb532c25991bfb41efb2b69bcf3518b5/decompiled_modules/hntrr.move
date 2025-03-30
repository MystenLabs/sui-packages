module 0xa1a69db1ce8a463b866089f98d06b0f2eb532c25991bfb41efb2b69bcf3518b5::hntrr {
    struct HNTRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HNTRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HNTRR>(arg0, 9, b"HNTRR", b"Hunter", b"a motivation to all hustler, joy is very close by", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5794966cc3623158fa9080ccb95cc772blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HNTRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HNTRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

