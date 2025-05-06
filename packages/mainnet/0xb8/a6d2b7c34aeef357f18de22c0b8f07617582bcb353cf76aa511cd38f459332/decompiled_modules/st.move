module 0xb8a6d2b7c34aeef357f18de22c0b8f07617582bcb353cf76aa511cd38f459332::st {
    struct ST has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST>(arg0, 9, b"ST", b"sattoshi", b"if sattoshi is a boy?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e0e0ed170e80c8c6df94ea9b03a3fd02blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

