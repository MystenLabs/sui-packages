module 0xa83912972b09c8e6cced90a8a041add1ad6e9e9148610a45777bd9815cd6dd74::llm {
    struct LLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LLM>(arg0, 9, b"LLM", b"lambo", x"4661737420616e6420657870656e736976650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f674d7f-02b6-4486-8bfc-2469c64e66b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

