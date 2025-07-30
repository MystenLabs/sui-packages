module 0xf9b2b177562a6e823e4612145716ba0f35cd886a34a0984324b542f7ad821893::SEALW {
    struct SEALW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEALW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEALW>(arg0, 6, b"SealWave", b"SEALW", b"SealWave is the ultimate meme coin for fans of animated seals! Dive into the fun with this playful and community-driven cryptocurrency. Whether you love seals for their cuteness or their quirky animations, SealWave is your ticket to the coolest meme coin in the ocean. Join the wave and let's make a splash!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://replicate.delivery/xezq/Yqb61Wv8qA6KMtD3ce8kWkd7d6iEejKqbCDMopo7mG55GfLqA/out-0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEALW>>(v0, @0x2be6c850562754e11af55b7f049f4e304e488dff630b3832874d80c837c458a8);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEALW>>(v1);
    }

    // decompiled from Move bytecode v6
}

