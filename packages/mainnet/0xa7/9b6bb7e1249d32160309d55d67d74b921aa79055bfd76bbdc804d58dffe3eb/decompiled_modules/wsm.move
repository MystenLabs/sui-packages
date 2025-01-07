module 0xa79b6bb7e1249d32160309d55d67d74b921aa79055bfd76bbdc804d58dffe3eb::wsm {
    struct WSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WSM>(arg0, 6, b"WSM", b"WALLSTREET MAGA", x"2457534d20436f696e200a0a4120766f746520666f72205452554d50206973206120766f746520666f72204d4147410a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4281_93c5435d89.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WSM>>(v1);
    }

    // decompiled from Move bytecode v6
}

