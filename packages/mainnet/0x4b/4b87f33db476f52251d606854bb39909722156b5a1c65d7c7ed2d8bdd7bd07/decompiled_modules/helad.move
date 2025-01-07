module 0x4b4b87f33db476f52251d606854bb39909722156b5a1c65d7c7ed2d8bdd7bd07::helad {
    struct HELAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HELAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HELAD>(arg0, 9, b"HELAD", b"Hello", b"dfasdfasdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/644d2e83-fbca-478a-887e-5546cd8e34d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HELAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HELAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

