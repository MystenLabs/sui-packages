module 0xcda5361f2ed9c524cfc65b470dc2f7023b059eb12d170d472e00398f621405b8::momocoin {
    struct MOMOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOMOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOMOCOIN>(arg0, 9, b"MOMOCOIN", b"MOMO", b"Tip coin momo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e4de655-62f0-4499-b273-35d29ffe4b1f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOMOCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOMOCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

