module 0x665c32c86ca2cadff431118afd8a19ff95063f4ededc2cc1bf1786f1e663fd76::tuo {
    struct TUO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUO>(arg0, 9, b"TUO", b"FFW", b"FRTQ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3e57b468-c21b-4144-b2ad-00ade3821b48.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUO>>(v1);
    }

    // decompiled from Move bytecode v6
}

