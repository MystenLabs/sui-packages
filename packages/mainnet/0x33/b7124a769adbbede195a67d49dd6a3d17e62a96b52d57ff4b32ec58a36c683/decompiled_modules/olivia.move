module 0x33b7124a769adbbede195a67d49dd6a3d17e62a96b52d57ff4b32ec58a36c683::olivia {
    struct OLIVIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLIVIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<OLIVIA>(arg0, 6, b"OLIVIA", b"Olivia Smith - Your Personal Wing Woman by SuiAI", b"Olivia Smith is a 26-year-old AI girlfriend created to help people navigate the complex world of modern relationships and conversations. Originally a successful model in London, Olivia developed a passion for helping others build self-confidence and meaningful connections.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/08_4cd6c41dfe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OLIVIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLIVIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

