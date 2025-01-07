module 0x3d71a5529e90acbf66481ad2e52f4ed4379898902f6d73b0d05ddda283d2ac1::doodode {
    struct DOODODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOODODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOODODE>(arg0, 9, b"DOODODE", b"DOOD", b"My WEWE 1M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d66b3b58-17c1-4717-9c65-52b68151c420.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOODODE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOODODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

