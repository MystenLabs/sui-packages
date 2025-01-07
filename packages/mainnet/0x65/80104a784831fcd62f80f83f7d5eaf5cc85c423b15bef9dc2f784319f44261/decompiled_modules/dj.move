module 0x6580104a784831fcd62f80f83f7d5eaf5cc85c423b15bef9dc2f784319f44261::dj {
    struct DJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DJ>(arg0, 9, b"DJ", b"Cockfighti", x"4a75737420676f7420686f6d6520616e642049e280996d206a7573742067657474696e6720", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f560be53-723f-4336-bc08-589b8c85c307.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DJ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DJ>>(v1);
    }

    // decompiled from Move bytecode v6
}

