module 0x15a5aa272ddbc1fae39d3f9fefa357ef48d8f2fcb40b25609fe0644a7f2c6312::mrsl {
    struct MRSL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRSL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRSL>(arg0, 9, b"MRSL", b"marsele ", b"more interesting ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c886a99b1069317ab79b236650f57179blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRSL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRSL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

