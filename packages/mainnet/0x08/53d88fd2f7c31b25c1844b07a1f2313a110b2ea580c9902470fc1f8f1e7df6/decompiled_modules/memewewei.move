module 0x853d88fd2f7c31b25c1844b07a1f2313a110b2ea580c9902470fc1f8f1e7df6::memewewei {
    struct MEMEWEWEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEWEWEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEWEWEI>(arg0, 9, b"MEMEWEWEI", b"Memewewe", b"Token wewei", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/608cb239-4c96-474b-88d5-25dafc314894.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEWEWEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEWEWEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

