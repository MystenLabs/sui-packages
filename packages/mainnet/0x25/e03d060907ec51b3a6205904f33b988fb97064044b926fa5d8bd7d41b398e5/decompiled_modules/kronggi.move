module 0x25e03d060907ec51b3a6205904f33b988fb97064044b926fa5d8bd7d41b398e5::kronggi {
    struct KRONGGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRONGGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRONGGI>(arg0, 9, b"KRONGGI", b"Ciito", b"The new meme of cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5b552b16-b7a4-4930-8873-f0d3a2f82ff7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRONGGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRONGGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

