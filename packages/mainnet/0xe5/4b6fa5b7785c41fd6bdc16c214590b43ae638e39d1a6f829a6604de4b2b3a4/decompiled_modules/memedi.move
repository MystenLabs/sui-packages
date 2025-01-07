module 0xe54b6fa5b7785c41fd6bdc16c214590b43ae638e39d1a6f829a6604de4b2b3a4::memedi {
    struct MEMEDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEDI>(arg0, 9, b"MEMEDI", b"Meme Dino ", b"Meme Dino World ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d851044-0a2d-4976-884b-8ded5b016b11.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

