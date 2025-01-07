module 0x67b8943a7d7eb57752ea110a4756c9f2590211e805c56e5cd44496b59c6d6326::dcky {
    struct DCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKY>(arg0, 9, b"DCKY", b"DuckyDuck", b"Token for someon love a duck", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c66b7fdb-9a6d-4cdd-ad93-cbf963e76745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

