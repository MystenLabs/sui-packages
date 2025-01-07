module 0xc2136366bd6a228bd18f5d301367f7fe47d87ec47e4fac9c0a975ab24fc51b13::me {
    struct ME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ME>(arg0, 9, b"ME", b"Meow", b"Meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/251aab56-bb28-4604-aa55-4b35b229c5fb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ME>>(v1);
    }

    // decompiled from Move bytecode v6
}

