module 0xe37eeb7348c0e4b54c71aa78cc3a799efe8ec84ffa8f46d624e83ad30fac1250::tolol {
    struct TOLOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOLOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOLOL>(arg0, 9, b"TOLOL", b"tolol ", b"just idiot bump!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4c1f4c79-6aea-4ff8-a3e6-f0f2428494f0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOLOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOLOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

