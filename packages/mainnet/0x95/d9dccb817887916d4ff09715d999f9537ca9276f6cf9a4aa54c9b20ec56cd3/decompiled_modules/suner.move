module 0x95d9dccb817887916d4ff09715d999f9537ca9276f6cf9a4aa54c9b20ec56cd3::suner {
    struct SUNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNER>(arg0, 9, b"SUNER", b"sun", b"NEW MEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a058edf78e5f688a1eb0b02e7588f591blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

