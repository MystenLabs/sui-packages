module 0xe4fdf421f067972dfbb44d483627da64fd0a836d5115631eef4d43a868e43feb::expol {
    struct EXPOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXPOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXPOL>(arg0, 9, b"EXPOL", b"EXPOLITEN ", b"Everyone is a little bin punk at heart.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5868301-70ee-4430-93b9-02f407352c8f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXPOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EXPOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

