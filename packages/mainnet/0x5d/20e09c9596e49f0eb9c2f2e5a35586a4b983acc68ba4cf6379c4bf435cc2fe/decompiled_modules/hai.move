module 0x5d20e09c9596e49f0eb9c2f2e5a35586a4b983acc68ba4cf6379c4bf435cc2fe::hai {
    struct HAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAI>(arg0, 9, b"HAI", b"Wewe", b"Wewe meme coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0bd364cc-6aa6-4d80-9bbe-fbbd491b5d47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

