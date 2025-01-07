module 0x9270aa22c70473599d7d25667cdb48597d976a022c39272fd7ea5e501405c662::aaab {
    struct AAAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAB>(arg0, 6, b"aaaB", b"AAA Battery", b"aaa battery is ready to charge up Sui to 100%", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_20_05_41_6e4b2ad61a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

