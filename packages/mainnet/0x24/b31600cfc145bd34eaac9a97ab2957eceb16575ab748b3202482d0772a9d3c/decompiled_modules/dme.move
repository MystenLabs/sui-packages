module 0x24b31600cfc145bd34eaac9a97ab2957eceb16575ab748b3202482d0772a9d3c::dme {
    struct DME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DME>(arg0, 9, b"DME", b"Duck Meme", b"Duck meme s", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08e75c36-e66d-4929-aaa7-7b32aedc52f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DME>>(v1);
    }

    // decompiled from Move bytecode v6
}

