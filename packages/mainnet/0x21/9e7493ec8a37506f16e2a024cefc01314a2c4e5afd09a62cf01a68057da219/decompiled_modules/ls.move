module 0x219e7493ec8a37506f16e2a024cefc01314a2c4e5afd09a62cf01a68057da219::ls {
    struct LS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LS>(arg0, 9, b"LS", b"Znsj", b"Mdslcm na frlsl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b7b589a7-8150-4632-b57f-015275a1757f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LS>>(v1);
    }

    // decompiled from Move bytecode v6
}

