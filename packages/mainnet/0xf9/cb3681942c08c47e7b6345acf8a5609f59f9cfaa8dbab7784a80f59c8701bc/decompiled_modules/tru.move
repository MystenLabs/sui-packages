module 0xf9cb3681942c08c47e7b6345acf8a5609f59f9cfaa8dbab7784a80f59c8701bc::tru {
    struct TRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRU>(arg0, 9, b"TRU", b"TURU", b"GOOD PROJECT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd6b6784-14c5-4a36-86ac-eacc2f521420.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRU>>(v1);
    }

    // decompiled from Move bytecode v6
}

