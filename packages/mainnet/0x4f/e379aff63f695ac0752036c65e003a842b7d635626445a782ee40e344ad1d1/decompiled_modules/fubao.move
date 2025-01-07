module 0x4fe379aff63f695ac0752036c65e003a842b7d635626445a782ee40e344ad1d1::fubao {
    struct FUBAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUBAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUBAO>(arg0, 9, b"FUBAO", b"Fubao", b"Panda fubao", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b046bb7-dc35-4e5f-8e11-7a40b00fed6e-IMG_4633.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUBAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FUBAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

