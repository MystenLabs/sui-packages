module 0x15fff9fb93fc01b9c2e1621b447990ad716d25888560057f28569eda4bd98594::tknm {
    struct TKNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKNM>(arg0, 9, b"TKNM", b"token", b"vip", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f4e11d3d-b761-4a94-8b25-f243cf51d92f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

