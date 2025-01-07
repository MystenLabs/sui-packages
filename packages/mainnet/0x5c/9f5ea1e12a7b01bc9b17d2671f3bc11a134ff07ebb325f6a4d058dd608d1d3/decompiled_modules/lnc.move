module 0x5c9f5ea1e12a7b01bc9b17d2671f3bc11a134ff07ebb325f6a4d058dd608d1d3::lnc {
    struct LNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: LNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LNC>(arg0, 9, b"LNC", b"Lincoln", b"Lincoln club ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/463c44b1-4287-4403-8bfe-046510a60017.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

