module 0x8437dd738f18fd9a6cd128a19414015d8995e507b80eb1e5bcad77f177d30e54::menene {
    struct MENENE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENENE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENENE>(arg0, 9, b"MENENE", b"Anime", b"This all time high", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0305289c-8334-49ea-9b68-25b7e6ec742c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENENE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MENENE>>(v1);
    }

    // decompiled from Move bytecode v6
}

