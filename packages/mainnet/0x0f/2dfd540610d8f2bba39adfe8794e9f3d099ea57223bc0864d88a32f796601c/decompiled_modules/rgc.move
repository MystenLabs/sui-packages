module 0xf2dfd540610d8f2bba39adfe8794e9f3d099ea57223bc0864d88a32f796601c::rgc {
    struct RGC has drop {
        dummy_field: bool,
    }

    fun init(arg0: RGC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RGC>(arg0, 9, b"RGC", b"Ringcoin ", b"RingCoin is a fun, accessible memecoin inspired by smartphones, bringing digital currency to life!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f64d6b01-2794-4aba-80ff-7d52b790fcf0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RGC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RGC>>(v1);
    }

    // decompiled from Move bytecode v6
}

