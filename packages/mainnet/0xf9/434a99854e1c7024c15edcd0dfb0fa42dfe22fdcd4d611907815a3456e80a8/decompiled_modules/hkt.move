module 0xf9434a99854e1c7024c15edcd0dfb0fa42dfe22fdcd4d611907815a3456e80a8::hkt {
    struct HKT has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HKT>(arg0, 9, b"HKT", b"htk", b"muyuu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9b28a0f1-d010-44da-9044-f48ef2995352.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HKT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HKT>>(v1);
    }

    // decompiled from Move bytecode v6
}

