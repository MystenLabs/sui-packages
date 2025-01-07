module 0xeef3c4ec805ada5e6dd2cae638c9139a9c5841317bb39be219b976b5c5cae644::shsj {
    struct SHSJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHSJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHSJ>(arg0, 9, b"SHSJ", b"Bsj", b"Dhdu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4274b122-f22a-485f-a14c-8f1d6512d04b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHSJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHSJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

