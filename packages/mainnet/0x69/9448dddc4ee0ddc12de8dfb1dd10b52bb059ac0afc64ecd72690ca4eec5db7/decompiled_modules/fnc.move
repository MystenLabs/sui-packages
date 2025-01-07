module 0x699448dddc4ee0ddc12de8dfb1dd10b52bb059ac0afc64ecd72690ca4eec5db7::fnc {
    struct FNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNC>(arg0, 9, b"FNC", b"Fincoin", b"Memecoin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0dd2d58e-fae9-46d1-abd5-35ec59cce651.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

