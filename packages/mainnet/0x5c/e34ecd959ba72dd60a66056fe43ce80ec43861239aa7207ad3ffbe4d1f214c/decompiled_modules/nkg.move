module 0x5ce34ecd959ba72dd60a66056fe43ce80ec43861239aa7207ad3ffbe4d1f214c::nkg {
    struct NKG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKG>(arg0, 9, b"NKG", b"NICEKING", b"MY WEWE MEME COIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/029981d3-28f3-4ab9-8a3c-a6dda8a4e1fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKG>>(v1);
    }

    // decompiled from Move bytecode v6
}

