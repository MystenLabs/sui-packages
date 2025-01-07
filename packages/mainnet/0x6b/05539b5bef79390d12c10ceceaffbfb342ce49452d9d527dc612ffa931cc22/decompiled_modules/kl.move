module 0x6b05539b5bef79390d12c10ceceaffbfb342ce49452d9d527dc612ffa931cc22::kl {
    struct KL has drop {
        dummy_field: bool,
    }

    fun init(arg0: KL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KL>(arg0, 9, b"KL", b"Khanhla", b"Lakhang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/75bf22a9-f978-4ba7-85bf-3a644cce64a4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KL>>(v1);
    }

    // decompiled from Move bytecode v6
}

