module 0xad66849dd1c9bfe70601463db4e43c5c99d4decc8b6ce8dd2090235ce7678025::pampi {
    struct PAMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPI>(arg0, 9, b"PAMPI", b"Pampi", b"Inspried by Disney cartoon deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/afff7e33-d65b-4e16-b203-d3cb8810dd39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

