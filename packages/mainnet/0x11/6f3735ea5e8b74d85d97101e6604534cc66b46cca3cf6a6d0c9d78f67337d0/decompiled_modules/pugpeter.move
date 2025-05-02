module 0x116f3735ea5e8b74d85d97101e6604534cc66b46cca3cf6a6d0c9d78f67337d0::pugpeter {
    struct PUGPETER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGPETER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGPETER>(arg0, 9, b"PUGPETER", b"PETER", b"contrar scan technological agent", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a3a1053b7e31a04295f4806664af1ea1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGPETER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGPETER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

