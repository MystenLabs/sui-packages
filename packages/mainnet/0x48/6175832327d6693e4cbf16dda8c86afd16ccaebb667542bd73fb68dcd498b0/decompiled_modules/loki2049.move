module 0x486175832327d6693e4cbf16dda8c86afd16ccaebb667542bd73fb68dcd498b0::loki2049 {
    struct LOKI2049 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOKI2049, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOKI2049>(arg0, 9, b"LOKI2049", b"loki", b"TOKEN 2049 TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fbad6780-7270-4a35-9d29-c2bda0dd8461.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOKI2049>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOKI2049>>(v1);
    }

    // decompiled from Move bytecode v6
}

