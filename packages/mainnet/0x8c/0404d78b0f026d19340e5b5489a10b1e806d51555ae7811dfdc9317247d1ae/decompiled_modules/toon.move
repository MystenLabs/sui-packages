module 0x8c0404d78b0f026d19340e5b5489a10b1e806d51555ae7811dfdc9317247d1ae::toon {
    struct TOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOON>(arg0, 9, b"TOON", b"SuiToon", b"SuiToon aims to become the go-to meme token for the Sui community, fostering a culture of creativity, fun, and collaboration. By blending humor, digital art, and web3 gaming,", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4a59fe6f-3c30-46df-9bf9-8fab7a6d8bc5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

