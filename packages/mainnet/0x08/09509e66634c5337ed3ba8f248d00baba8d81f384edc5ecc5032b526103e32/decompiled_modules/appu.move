module 0x809509e66634c5337ed3ba8f248d00baba8d81f384edc5ecc5032b526103e32::appu {
    struct APPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: APPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APPU>(arg0, 9, b"APPU", b"Appus", b"Yes I'm appu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ded52a3e-3274-46c6-b804-6fe689c162cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

