module 0xf723f368891675d68150746a9d1f4d540a4965ad8a4c25f18d40c87db1064662::hel {
    struct HEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEL>(arg0, 9, b"Hel", b"hell", b"welcome to hell", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/1e1c659979ada087596aa21d79b0d21eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

