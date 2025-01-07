module 0x5786265b4f5d2590210ffd3186bf202127edccea918128981e350b244c929d56::pampi {
    struct PAMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAMPI>(arg0, 9, b"PAMPI", b"Pampi", b"Inspried by Disney cartoon deer", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dc3142fc-4770-401b-a72d-742291619a0b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

