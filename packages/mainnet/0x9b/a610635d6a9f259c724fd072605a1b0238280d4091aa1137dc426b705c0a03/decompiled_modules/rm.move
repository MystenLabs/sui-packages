module 0x9ba610635d6a9f259c724fd072605a1b0238280d4091aa1137dc426b705c0a03::rm {
    struct RM has drop {
        dummy_field: bool,
    }

    fun init(arg0: RM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RM>(arg0, 9, b"RM", x"526175206d75e1bb916e6720", x"526175206d75e1bb916e67206c75e1bb9963", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e552f4f-13cb-48fd-bbc4-d54fdfc192ae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RM>>(v1);
    }

    // decompiled from Move bytecode v6
}

