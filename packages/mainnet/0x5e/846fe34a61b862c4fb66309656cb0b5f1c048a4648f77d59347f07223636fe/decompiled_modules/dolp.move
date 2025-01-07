module 0x5e846fe34a61b862c4fb66309656cb0b5f1c048a4648f77d59347f07223636fe::dolp {
    struct DOLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLP>(arg0, 9, b"DOLP", b"DOLPHIN", b"Blupppuppp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d5d8929f-075e-411f-a8b2-117baf2e2447-images (41).jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOLP>>(v1);
    }

    // decompiled from Move bytecode v6
}

