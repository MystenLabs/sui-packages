module 0xf6b77385f6589e11489967f8d0a98b6d589a024b4d14475c51c462d852a762eb::dtrump {
    struct DTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTRUMP>(arg0, 9, b"DTRUMP", b"DTrump", b"Donald trump token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a6d48e32-8b7b-4ae6-844b-dbd5082965d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

