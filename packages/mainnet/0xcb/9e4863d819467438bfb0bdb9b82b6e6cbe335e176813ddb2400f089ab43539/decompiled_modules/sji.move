module 0xcb9e4863d819467438bfb0bdb9b82b6e6cbe335e176813ddb2400f089ab43539::sji {
    struct SJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SJI>(arg0, 9, b"SJI", b"Saiji", b"Purely meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2dc746d-dc45-4ac6-bf04-8ac2278d466d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

