module 0x8f5d28065a150f3cadcf5a4ec590a6f5807dafd7e74ac83ce84237005f631bb::ahah {
    struct AHAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AHAH>(arg0, 9, b"AHAH", b"Ahah Meme", b"Ahah memecoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf785a3e-46ed-417a-abdb-435a7332a81e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AHAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

