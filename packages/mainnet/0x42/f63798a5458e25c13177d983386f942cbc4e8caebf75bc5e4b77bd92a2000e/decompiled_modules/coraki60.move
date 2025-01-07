module 0x42f63798a5458e25c13177d983386f942cbc4e8caebf75bc5e4b77bd92a2000e::coraki60 {
    struct CORAKI60 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CORAKI60, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CORAKI60>(arg0, 9, b"CORAKI60", b"Monika", b"leben lieben lachen SEIN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbde6357-7c99-4687-8d88-c4866e43cb4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CORAKI60>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CORAKI60>>(v1);
    }

    // decompiled from Move bytecode v6
}

