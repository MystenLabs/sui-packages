module 0x3024ed0aa165a7f4b5af8c0968fff771ebce105151ca50eefeac37b8adb6ba88::pih {
    struct PIH has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIH>(arg0, 9, b"PIH", b"POPISHERE", b"pop is here is the official meme coin of pop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/be634e078f975f4b17bcbd94516fef09blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

