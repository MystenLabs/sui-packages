module 0xf68ab2dab6e0af3a6df6cc66e45e9ccfe5ba380eac1b3d73986c5773d9cbfda2::manu {
    struct MANU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANU>(arg0, 9, b"MANU", b"FC ManU", b"ManU never give up ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4602879-f3af-4dd9-9693-7b6ab7760f93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MANU>>(v1);
    }

    // decompiled from Move bytecode v6
}

