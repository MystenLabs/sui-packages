module 0xe9a8d8982761e7934f829c9155e17cff069696ce6a26314d498bf316964db29f::bllm {
    struct BLLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLLM>(arg0, 9, b"BLLM", b"BLUBBYGIRL", b"blubby its chic and fox", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd023793-5d9d-4f28-92be-82215aa5cb81.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

