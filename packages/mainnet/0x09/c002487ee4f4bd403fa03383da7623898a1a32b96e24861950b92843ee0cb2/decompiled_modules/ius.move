module 0x9c002487ee4f4bd403fa03383da7623898a1a32b96e24861950b92843ee0cb2::ius {
    struct IUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IUS>(arg0, 9, b"IUS", b"ius", b"IUS is SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/33944f29-4d0c-43bf-89cb-3c4644b2339c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

