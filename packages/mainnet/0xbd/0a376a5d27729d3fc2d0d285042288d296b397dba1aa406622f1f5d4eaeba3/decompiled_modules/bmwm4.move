module 0xbd0a376a5d27729d3fc2d0d285042288d296b397dba1aa406622f1f5d4eaeba3::bmwm4 {
    struct BMWM4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMWM4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMWM4>(arg0, 9, b"BMWM4", b"BMW", b"Make my wish come true so that I can make many other poor children's wishes come true", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2cc6ba97-39de-4f51-ae53-5f88ddc345da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMWM4>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMWM4>>(v1);
    }

    // decompiled from Move bytecode v6
}

