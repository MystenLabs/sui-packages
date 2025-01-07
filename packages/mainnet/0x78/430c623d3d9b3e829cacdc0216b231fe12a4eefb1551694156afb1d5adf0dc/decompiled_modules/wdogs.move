module 0x78430c623d3d9b3e829cacdc0216b231fe12a4eefb1551694156afb1d5adf0dc::wdogs {
    struct WDOGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WDOGS>(arg0, 9, b"WDOGS", b"WEWEDOGS", b"WeweDogs is a meme coin Build on Sui Blockchain which will serve as a community token for assisting and supporting less privilege people around the world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1dffd3ee-72aa-468a-9159-b072854a0b6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDOGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDOGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

