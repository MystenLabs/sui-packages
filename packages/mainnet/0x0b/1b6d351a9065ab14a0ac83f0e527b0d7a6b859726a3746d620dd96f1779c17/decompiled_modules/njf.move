module 0xb1b6d351a9065ab14a0ac83f0e527b0d7a6b859726a3746d620dd96f1779c17::njf {
    struct NJF has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJF>(arg0, 9, b"NJF", b"TR", b"DFFFFGB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/126b7e7e-cd8e-4300-97ea-6eef2f61c333.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJF>>(v1);
    }

    // decompiled from Move bytecode v6
}

