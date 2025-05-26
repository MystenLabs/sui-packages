module 0x82f4e2abd1390f6dcddeb02374d841fff2eec2bae2ca2b034415b85f8e986b57::stw {
    struct STW has drop {
        dummy_field: bool,
    }

    fun init(arg0: STW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STW>(arg0, 9, b"STW", b"STAR WARS", b"STAR WARS TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9def0b363c04bf03d1c91984fa0e6d22blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

