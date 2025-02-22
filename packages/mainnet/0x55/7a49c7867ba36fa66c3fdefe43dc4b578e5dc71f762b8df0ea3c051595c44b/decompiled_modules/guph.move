module 0x557a49c7867ba36fa66c3fdefe43dc4b578e5dc71f762b8df0ea3c051595c44b::guph {
    struct GUPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUPH>(arg0, 9, b"GUPH", b"Gohs Uphanishads", b"*", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8b6d52d621d4b3ee0f250831f67cff97blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUPH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUPH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

