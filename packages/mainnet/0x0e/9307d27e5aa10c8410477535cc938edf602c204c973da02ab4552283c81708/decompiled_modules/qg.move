module 0xe9307d27e5aa10c8410477535cc938edf602c204c973da02ab4552283c81708::qg {
    struct QG has drop {
        dummy_field: bool,
    }

    fun init(arg0: QG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QG>(arg0, 9, b"Qg", b"dfsjh", b"tydj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/da14256263620a80ebb7600d3cccf062blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

