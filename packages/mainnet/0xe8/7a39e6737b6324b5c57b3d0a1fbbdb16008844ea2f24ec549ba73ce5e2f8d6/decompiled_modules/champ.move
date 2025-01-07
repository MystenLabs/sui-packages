module 0xe87a39e6737b6324b5c57b3d0a1fbbdb16008844ea2f24ec549ba73ce5e2f8d6::champ {
    struct CHAMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAMP>(arg0, 9, b"CHAMP", b"CHAMPION", b"Token that specifically design for the ultimate winner and champion", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9e65999c-fbc6-4371-9a8b-51141defbce5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

