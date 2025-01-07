module 0xb574775449448932c824025904720eb8b1c67ed7f46dcc3cd34d174bb54084db::kim {
    struct KIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIM>(arg0, 9, b"KIM", b"Kymik", x"49e280996d206e6f74206120626967206465616c2061742074686520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6be8ad66-abb1-46b4-9955-39a652037f7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

