module 0x8237244448872b999aeec99238e074622701fbdacf23616003398dd0c95e7ecd::wiff {
    struct WIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFF>(arg0, 9, b"WIFF", b"Mandarin", b"Late", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f8ec8a4-5447-4298-bbcb-f086b31d0ccd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

