module 0xb7a030339a632a7231a58a2995f4f979ebbfb6901303e8886c8131102ca31a49::sfk {
    struct SFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFK>(arg0, 9, b"SFK", b"SEFIDAK", b"SEFIDAK TOKEN. BUY IT. YOU DO NOT REGRET.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17cfd77d-b07b-4e59-9672-695d55d9cc4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

