module 0x5d3a009ac2f485d0d6314e94a6b3f7de3a26771dd94ee3b787126f91a5ddeed0::coys {
    struct COYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: COYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COYS>(arg0, 9, b"COYS", b"TottenhamChamps", b"GOGOGO TO WIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8e8c1cbe4422d76be7fbcc6c3c0fe33eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COYS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COYS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

