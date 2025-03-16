module 0x235d709a619b133188484ad6f9000ca1cb9ed9710af1cfc1eede67a1d26d1582::dadtc {
    struct DADTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DADTC>(arg0, 9, b"DADTC", b"Daddy Tucker Carlson coin", b"Tucker Carlson is daddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2f6727ebdb47d04a110a12a242b1b9a5blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DADTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

