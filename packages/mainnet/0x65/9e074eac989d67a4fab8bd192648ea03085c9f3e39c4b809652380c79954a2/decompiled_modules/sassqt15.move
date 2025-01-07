module 0x659e074eac989d67a4fab8bd192648ea03085c9f3e39c4b809652380c79954a2::sassqt15 {
    struct SASSQT15 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSQT15, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSQT15>(arg0, 9, b"SASSQT15", b"SASSQUATCH", b"unloving moody meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/be70d54e-9616-402e-b5fd-6061e2850f6d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSQT15>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SASSQT15>>(v1);
    }

    // decompiled from Move bytecode v6
}

