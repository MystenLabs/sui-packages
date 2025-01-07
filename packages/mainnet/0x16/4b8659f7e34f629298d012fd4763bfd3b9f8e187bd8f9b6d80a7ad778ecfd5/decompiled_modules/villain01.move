module 0x164b8659f7e34f629298d012fd4763bfd3b9f8e187bd8f9b6d80a7ad778ecfd5::villain01 {
    struct VILLAIN01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILLAIN01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILLAIN01>(arg0, 9, b"VILLAIN01", b"Villains", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ba7e8039-f3a9-40dd-817e-ed73da77d1cf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILLAIN01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VILLAIN01>>(v1);
    }

    // decompiled from Move bytecode v6
}

