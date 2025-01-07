module 0xf6f370821adab95ec8ac9f6859120aaf478d3eba3e1e12af1a810ee7bbcee51e::sht {
    struct SHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHT>(arg0, 9, b"SHT", b"Shitmeme", b"Trade new meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/053a00cb-c7b7-4ec8-9a7b-17f9af74ce73.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHT>>(v1);
    }

    // decompiled from Move bytecode v6
}

