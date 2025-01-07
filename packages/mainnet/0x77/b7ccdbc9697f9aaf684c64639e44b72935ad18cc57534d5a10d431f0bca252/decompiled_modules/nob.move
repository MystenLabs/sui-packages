module 0x77b7ccdbc9697f9aaf684c64639e44b72935ad18cc57534d5a10d431f0bca252::nob {
    struct NOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOB>(arg0, 9, b"NOB", b"Noob", b"meme community for blastroyale gamers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c3013ad-4fca-4f33-a831-f67a89721e7b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

