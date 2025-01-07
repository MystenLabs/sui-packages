module 0x5f325131c1a65226e4ea37f3589f12fb9d5ea570c35abf9961bfe1d191a7ad73::nakawewe {
    struct NAKAWEWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAKAWEWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAKAWEWE>(arg0, 9, b"NAKAWEWE", b"WEWE", b"Suitoshi Nakawewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a8886b7d-452b-49e7-8ca2-41f99fd3eb31.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAKAWEWE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAKAWEWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

