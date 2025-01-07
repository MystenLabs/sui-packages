module 0xd6d76fcd6f49becac0120eed5ee03c209cd562af8ed3a9ee457bc8d363723d2a::dgn {
    struct DGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGN>(arg0, 9, b"DGN", b"Degen talk", b"Degen token is for degen traders and degen token is for small traders that want be a big trader and for any crypto man ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5735efc3-633e-45b4-bfd4-75929dea2a7d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

