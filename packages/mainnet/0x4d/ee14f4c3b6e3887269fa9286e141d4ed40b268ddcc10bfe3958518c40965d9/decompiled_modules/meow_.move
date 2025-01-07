module 0x4dee14f4c3b6e3887269fa9286e141d4ed40b268ddcc10bfe3958518c40965d9::meow_ {
    struct MEOW_ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW_, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOW_>(arg0, 9, b"MEOW_", b"meow4x", b"meow meow meow meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3c56150-7c2f-4161-90f5-b60182bbd54c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW_>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOW_>>(v1);
    }

    // decompiled from Move bytecode v6
}

