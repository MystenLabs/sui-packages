module 0x335470d7fd24df67f7cf631a9de1b3a8f83b47e6fada41ddd8a49e450dc7ad1d::mumu {
    struct MUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMU>(arg0, 9, b"MUMU", b"Mumu the b", b"The masscot of bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4e7fbcb-cf5a-4c81-8dd6-095adf416566.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

