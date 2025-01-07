module 0x572ac68358c3f7bfd97e4aef2b41ad397d4000d510f71765268b4083426e83be::kong {
    struct KONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONG>(arg0, 9, b"KONG", b"King", b"Cute", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a9c65a2-5609-42fe-b43e-48be78e8f31f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

