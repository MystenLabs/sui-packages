module 0x859f38656159347e19a3b2dd705d8799f4d491768305a45928f8ccd2523ca39a::j5w6 {
    struct J5W6 has drop {
        dummy_field: bool,
    }

    fun init(arg0: J5W6, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J5W6>(arg0, 9, b"J5W6", b"k86e8s", b"tuyok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d60e8b7733d18ce611e9599ded710693blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<J5W6>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J5W6>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

