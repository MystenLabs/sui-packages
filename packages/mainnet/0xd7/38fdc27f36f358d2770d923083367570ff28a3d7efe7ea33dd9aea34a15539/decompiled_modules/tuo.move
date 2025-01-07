module 0xd738fdc27f36f358d2770d923083367570ff28a3d7efe7ea33dd9aea34a15539::tuo {
    struct TUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUO>(arg0, 9, b"TUO", b"FFW", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/063c57ef-d18a-4c74-a932-c560479eacbc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

