module 0x46a0cef1f37a922b36848c5fe1b864ce144a28296accd57b960dc0731705da18::drw {
    struct DRW has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRW>(arg0, 9, b"DRW", b"draww", b"fgfgt jtyer  juikyertrw3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/02490ce1606bbd870d20d27810092262blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRW>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRW>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

