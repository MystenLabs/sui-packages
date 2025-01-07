module 0xec5cce1eff01364388f208b1dcd50425a15e4544b7b6f7d2c0142538ddd9e68b::duc_811999 {
    struct DUC_811999 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUC_811999, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUC_811999>(arg0, 9, b"DUC_811999", x"c490756320416e68", x"c490e1bab9702074726169", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bd4abc5a-4172-442e-bdd1-c2225f037e24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUC_811999>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUC_811999>>(v1);
    }

    // decompiled from Move bytecode v6
}

