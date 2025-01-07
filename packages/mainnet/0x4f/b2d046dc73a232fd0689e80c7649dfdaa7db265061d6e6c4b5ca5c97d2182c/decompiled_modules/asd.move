module 0x4fb2d046dc73a232fd0689e80c7649dfdaa7db265061d6e6c4b5ca5c97d2182c::asd {
    struct ASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASD>(arg0, 6, b"ASD", b"asdas", b"S", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730991092843.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

