module 0x2f9b3a84b852a4d7a00fc78b1f10e94856806bf89bf7ee7e68dae3e0ae727c2::blo {
    struct BLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLO>(arg0, 9, b"BLO", b"BALON", b"ALONE BALONE IS SAD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/60f32e31-a47a-4ae3-ad5c-1e04d4ccbdba.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

