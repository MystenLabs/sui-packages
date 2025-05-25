module 0x85384899546e702c9e2fa60018bd76d2d9142b08165499b4c6dd900f6d0457f6::vtm {
    struct VTM has drop {
        dummy_field: bool,
    }

    fun init(arg0: VTM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VTM>(arg0, 9, b"VTM", b"Vitamon", b"Gerr mass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/70a1555fcb67e38f46efaa57b39b5546blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VTM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VTM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

