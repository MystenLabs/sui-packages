module 0x94a2aa14ff04eb9dcf4997769b4a7fc936b8b849819a5d8151bcb04e2a4dc581::dcky {
    struct DCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DCKY>(arg0, 9, b"DCKY", b"DuckyDuck", b"That is meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe20c20c-e2a7-41a0-8af5-bf318cc4316e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DCKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DCKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

