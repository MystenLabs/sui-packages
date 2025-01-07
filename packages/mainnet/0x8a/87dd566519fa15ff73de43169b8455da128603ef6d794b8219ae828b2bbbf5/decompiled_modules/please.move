module 0x8a87dd566519fa15ff73de43169b8455da128603ef6d794b8219ae828b2bbbf5::please {
    struct PLEASE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEASE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEASE>(arg0, 9, b"Please", b"Contact @filtrow on Telegram ", b"Dm $Orcie CMO @filtrow on telegram to talk about future of project and other important details", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/01e6805e05f0bdba65fab16f03490e58blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PLEASE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEASE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

