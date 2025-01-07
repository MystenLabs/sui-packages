module 0x2929d3662d90d4b11de7d7f6d0a6387a9df09e5ea74374aede20cab62b1e504c::sud {
    struct SUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUD>(arg0, 9, b"SUD", b"Superfuud", b"Fud or lose", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/200f305d-5b7d-4d12-9be8-cbb0253e7c42.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

