module 0x34ac701bf5db3947e0aecf49f8e9702648e852701f02c6851250f46f01165b5e::tamcoin {
    struct TAMCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMCOIN>(arg0, 9, b"TAMCOIN", b"TammyMille", b"trading wewe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88f0317a-2f9a-4dd5-8eb0-b82a2d1768a3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAMCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

