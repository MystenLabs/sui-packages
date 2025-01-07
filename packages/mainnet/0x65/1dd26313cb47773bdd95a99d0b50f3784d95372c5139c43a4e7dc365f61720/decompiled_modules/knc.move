module 0x651dd26313cb47773bdd95a99d0b50f3784d95372c5139c43a4e7dc365f61720::knc {
    struct KNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KNC>(arg0, 9, b"KNC", b"Kenanos ", b"Godisgood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b87b7f58-8414-40c6-8b07-f84264b6eb5f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

