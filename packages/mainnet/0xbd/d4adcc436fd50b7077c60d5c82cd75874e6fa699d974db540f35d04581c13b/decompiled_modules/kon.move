module 0xbdd4adcc436fd50b7077c60d5c82cd75874e6fa699d974db540f35d04581c13b::kon {
    struct KON has drop {
        dummy_field: bool,
    }

    fun init(arg0: KON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KON>(arg0, 9, b"KON", b"King Lion ", b"The king lion meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b11f45c-eaf5-47c4-8f37-685a028991dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KON>>(v1);
    }

    // decompiled from Move bytecode v6
}

