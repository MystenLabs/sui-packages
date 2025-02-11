module 0xfeca9015220513dfc991375204b509bcfcd553c9b90a42a4b410004e497d77e5::gmr {
    struct GMR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GMR>(arg0, 6, b"GMR", b"GMR by SuiAI", b"GMR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/download_993406bd19.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GMR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

