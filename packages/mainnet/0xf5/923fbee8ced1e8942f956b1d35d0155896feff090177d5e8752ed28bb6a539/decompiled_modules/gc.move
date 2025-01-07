module 0xf5923fbee8ced1e8942f956b1d35d0155896feff090177d5e8752ed28bb6a539::gc {
    struct GC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GC>(arg0, 9, b"GC", x"47c3ba74204368c3b370", x"4e676f6e206e68612061652076c3a06f207669e1bb8763", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/de75bd1f-211c-4778-90ef-d8d797e3e3c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GC>>(v1);
    }

    // decompiled from Move bytecode v6
}

