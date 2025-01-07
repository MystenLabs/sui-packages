module 0x8325569a2aae275ca0826056a11f99557c500bed38d0bc0b4b84a2fd5a59e4f3::nwmbeb {
    struct NWMBEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: NWMBEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NWMBEB>(arg0, 9, b"NWMBEB", b"hsjsn", b"hsiakq", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7c972ac2-e785-49f0-bf12-384ec70c01b0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NWMBEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NWMBEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

