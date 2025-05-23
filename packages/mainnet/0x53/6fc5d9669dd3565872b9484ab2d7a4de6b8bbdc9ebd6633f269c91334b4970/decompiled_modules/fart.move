module 0x536fc5d9669dd3565872b9484ab2d7a4de6b8bbdc9ebd6633f269c91334b4970::fart {
    struct FART has drop {
        dummy_field: bool,
    }

    fun init(arg0: FART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FART>(arg0, 9, b"FART", b"Dream Big Fart Loud", b"Dream Big Fart Loud The Gassiest cat on SUI Fartt-Fect. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c74134c7cbb8cb8bb0d6209dafd76af7blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FART>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FART>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

