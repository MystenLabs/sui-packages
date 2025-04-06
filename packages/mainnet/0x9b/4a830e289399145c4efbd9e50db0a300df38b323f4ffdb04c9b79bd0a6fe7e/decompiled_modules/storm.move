module 0x9b4a830e289399145c4efbd9e50db0a300df38b323f4ffdb04c9b79bd0a6fe7e::storm {
    struct STORM has drop {
        dummy_field: bool,
    }

    fun init(arg0: STORM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STORM>(arg0, 9, b"STORM", b"LEO", b"Leo storm coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/aae8d70039741162fac943a2d0cca4c1blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STORM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STORM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

