module 0xe0796209e31b908e7b970217133148be21e47f7e080bc31443f8ece4c2d7889::kamala {
    struct KAMALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAMALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMALA>(arg0, 9, b"KAMALA", b"$KAMALA H", b"$KAMALA is the meme of Kamala Harris the Democratic Nominee of the Presential Elections 2024. The ticker is Kamala.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e720295a-4675-41e7-b89f-a2ff8f626571-1000018850.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAMALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

