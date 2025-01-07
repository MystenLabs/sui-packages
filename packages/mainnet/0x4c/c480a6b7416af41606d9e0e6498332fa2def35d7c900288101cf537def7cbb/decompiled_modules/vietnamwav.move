module 0x4cc480a6b7416af41606d9e0e6498332fa2def35d7c900288101cf537def7cbb::vietnamwav {
    struct VIETNAMWAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIETNAMWAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIETNAMWAV>(arg0, 9, b"VIETNAMWAV", b"VIETNAM", b"chung toi yeu viet nam. Viet nam muon nam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f91ce6ee-a684-4b7a-a2a8-8b8c27c8746a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIETNAMWAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIETNAMWAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

