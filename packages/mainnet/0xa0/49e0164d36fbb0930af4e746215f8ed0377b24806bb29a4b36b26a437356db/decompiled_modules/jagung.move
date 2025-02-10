module 0xa049e0164d36fbb0930af4e746215f8ed0377b24806bb29a4b36b26a437356db::jagung {
    struct JAGUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAGUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAGUNG>(arg0, 9, b"Jagung", b"Jagungcoin", b"Corn day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/364b4d9c64652bfc937eaaf03c0ff4a4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAGUNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAGUNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

