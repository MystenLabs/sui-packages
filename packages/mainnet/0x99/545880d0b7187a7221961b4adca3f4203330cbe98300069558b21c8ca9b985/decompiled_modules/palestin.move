module 0x99545880d0b7187a7221961b4adca3f4203330cbe98300069558b21c8ca9b985::palestin {
    struct PALESTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PALESTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PALESTIN>(arg0, 9, b"PALESTIN", b"palestine", b"FREE PALESTINE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7d715a269c41705689387df05019eb8ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PALESTIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PALESTIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

