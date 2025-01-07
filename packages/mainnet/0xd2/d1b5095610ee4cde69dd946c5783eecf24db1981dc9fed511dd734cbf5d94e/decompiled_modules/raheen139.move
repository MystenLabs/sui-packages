module 0xd2d1b5095610ee4cde69dd946c5783eecf24db1981dc9fed511dd734cbf5d94e::raheen139 {
    struct RAHEEN139 has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAHEEN139, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAHEEN139>(arg0, 9, b"RAHEEN139", b"Tariq", b"Wave", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/90602636-8a9d-4a4e-ba07-f887eb9a244b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAHEEN139>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RAHEEN139>>(v1);
    }

    // decompiled from Move bytecode v6
}

