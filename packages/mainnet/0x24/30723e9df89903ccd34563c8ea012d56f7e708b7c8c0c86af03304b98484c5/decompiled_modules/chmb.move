module 0x2430723e9df89903ccd34563c8ea012d56f7e708b7c8c0c86af03304b98484c5::chmb {
    struct CHMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHMB>(arg0, 9, b"CHMB", b"CHAMBALAM", b"This coin is the best bruv!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4c97760ae1767ae41090dff8a5ac55b8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHMB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

